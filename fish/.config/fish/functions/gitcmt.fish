
function gitcmt
    if test (count $argv) -lt 3
        echo 'Использование: gitcmt "YYYY-MM-DD" "HH:MM" "commit message"'
        return 1
    end

    set -l date_part $argv[1]
    set -l time_part $argv[2]
    set -l message $argv[3..-1]

    # Проверяем формат даты и времени
    if not string match -rq '^\d{4}-\d{2}-\d{2}$' -- $date_part
        echo "Ошибка: дата должна быть в формате YYYY-MM-DD"
        return 1
    end

    if not string match -rq '^\d{2}:\d{2}$' -- $time_part
        echo "Ошибка: время должно быть в формате HH:MM"
        return 1
    end

    # Случайные секунды и локальный часовой пояс
    set -l seconds (printf '%02d' (random 0 59))
    set -l timezone (date +%z)
    set -l full_date "$date_part $time_part:$seconds $timezone"

    # Устанавливаем даты только для этого git commit
    env \
        GIT_AUTHOR_DATE="$full_date" \
        GIT_COMMITTER_DATE="$full_date" \
        git commit -m (string join ' ' -- $message)
end
