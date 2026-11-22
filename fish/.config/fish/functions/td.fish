function __td_new
    set todos_dir ~/todos

    # создать папку если нет
    mkdir -p $todos_dir

    # дата
    set date (date "+%d_%m_%y")

    # если есть аргумент — используем как префикс
    if test (count $argv) -gt 0
        set base_name "$argv[1]_$date"
    else
        set base_name "$date"
    end

    set file "$todos_dir/$base_name.md"

    # если файл существует — добавляем n1, n2...
    set i 1
    while test -e $file
        set file "$todos_dir/$base_name"n"$i".md
        set i (math $i + 1)
    end

    # создать файл
    touch $file

    echo "Создан файл: $file"
    micro $file
end

function __td_today
    set todos_dir ~/todos
    mkdir -p $todos_dir

    set date (date "+%d_%m_%y")

    set prefix ""
    set n ""

    # разбираем аргументы
    if test (count $argv) -eq 1
        if string match -rq '^[0-9]+$' $argv[1]
            set n $argv[1]
        else
            set prefix $argv[1]
        end
    else if test (count $argv) -ge 2
        set prefix $argv[1]
        set n $argv[2]
    end

    # базовое имя
    if test -n "$prefix"
        set base_name "$prefix"_"$date"
    else
        set base_name "$date"
    end

    # если указан номер — добавляем nX
    if test -n "$n"
        set file "$todos_dir/$base_name"n"$n".md
    else
        set file "$todos_dir/$base_name.md"
    end

    # если файла нет — создаём
    if not test -e $file
        touch $file
    end

    micro $file
end


function __td_global
    set global_dir ~/todos
    mkdir -p $global_dir

    if test (count $argv) -eq 0
        echo "Использование: tdg имя_заметки"
        return 1
    end

    # аргумент в uppercase
    set name (string upper $argv[1])

    set file "$global_dir/g$name.md"

    # создать файл если нет
    if not test -e $file
        touch $file
    end

    micro $file
end

function __td_sync
    if test (count $argv) -eq 0
        echo "Использование: tdsync имя_заметки"
        return 1
    end

    set prefix $argv[1]
    set date (date "+%d_%m_%y")
    set todos_dir ~/todos
    set global_dir ~/todos   # глобальные заметки в той же папке
    mkdir -p $global_dir

    set gfile "$global_dir/g"(string upper $prefix)".md"

    if not test -e $gfile
        touch $gfile
    end

    set files (ls $todos_dir/$prefix"_"$date*.md 2>/dev/null)
    if test (count $files) -eq 0
        echo "Файлы за сегодня не найдены"
        return 0
    end

    set existing (cat $gfile)
    set tmpfile (mktemp)

    for f in $files
        set inside_note 0
        set note_lines ""
        set added_file_header 0

        cat $f | while read line
            set first4 (string sub -s 1 -l 4 -- "$line")

            if test "$first4" = "- [ "
                # новая незавершённая заметка
                if test $inside_note -eq 1
                    if not echo "$existing" | grep -Fq -- "$note_lines"
                        if test $added_file_header -eq 0
                            echo "**"(basename $f)"**" >> $tmpfile
                            set added_file_header 1
                        end
                        echo "$note_lines" >> $tmpfile
                        set existing "$existing
$note_lines"
                    end
                    set note_lines ""
                end
                set inside_note 1
                set note_lines "$line"
            else if test "$first4" = "- [x"
                # завершённая — игнорируем
                if test $inside_note -eq 1
                    if not echo "$existing" | grep -Fq -- "$note_lines"
                        if test $added_file_header -eq 0
                            echo "**"(basename $f)"**" >> $tmpfile
                            set added_file_header 1
                        end
                        echo "$note_lines" >> $tmpfile
                        set existing "$existing
$note_lines"
                    end
                    set note_lines ""
                end
                set inside_note 0
            else if test $inside_note -eq 1
                # многострочная
                set note_lines "$note_lines
$line"
            end
        end

        # добавить последнюю заметку из файла
        if test $inside_note -eq 1
            if not echo "$existing" | grep -Fq -- "$note_lines"
                if test $added_file_header -eq 0
                    echo "**"(basename $f)"**" >> $tmpfile
                    set added_file_header 1
                end
                echo "$note_lines" >> $tmpfile
                set existing "$existing
$note_lines"
            end
        end
    end

    if test -s $tmpfile
        cat $tmpfile >> $gfile
        echo "Добавлено новых задач в $gfile"
    else
        echo "Новых задач нет"
    end

    rm $tmpfile
end




function td
    if test (count $argv) -eq 0
        set cmd -h
    else
        set cmd $argv[1]
    end

    switch $cmd
        case "-h" "--help" "help"
            echo ""
            echo "Todo commands"
            echo ""
            echo "  tdn [prefix]"
            echo "      Create a new daily note."
            echo "      Creates n1, n2... if today's file already exists."
            echo ""
            echo "  tdt [prefix] [n]"
            echo "      Open today's note."
            echo "      Creates it if it doesn't exist."
            echo ""
            echo "  tdg <name>"
            echo "      Open a global note (gNAME.md)."
            echo ""
            echo "  tdsync <name>"
            echo "      Copy unfinished tasks from today's notes"
            echo "      into the global note."
            echo ""
            echo "Examples:"
            echo "  tdn"
            echo "  tdn work"
            echo "  tdt"
            echo "  tdt work"
            echo "  tdt work 2"
            echo "  tdg work"
            echo "  tdsync work"
            echo ""

        case "-n"
            __td_new $argv[2..-1]

        case "-t"
            __td_today $argv[2..-1]

        case "-g"
            __td_global $argv[2..-1]

        case "-s" "-sync"
            __td_sync $argv[2..-1]

        case "*"
            echo "Unknown command: $cmd"
            echo "Run 'td -h' for help."
            return 1
    end
end
