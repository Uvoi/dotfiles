function faillock-status
    set -l user_name $USER
    set -l deny 3
    set -l unlock_time 600

    if test (count $argv) -gt 0
        set user_name $argv[1]
    end

    set -l result (sudo faillock --user $user_name 2>/dev/null | awk '
        $1 ~ /^[0-9][0-9][0-9][0-9]-/ && $NF == "V" {
            count++
            last_date = $1
            last_time = $2
        }

        END {
            print count + 0
            print last_date
            print last_time
        }
    ')

    set -l attempts $result[1]

    echo "Пользователь: $user_name"
    echo "Неудачных попыток: $attempts / $deny"

    if test $attempts -eq 0
        echo "Статус: OK"
        return
    end

    if test $attempts -lt $deny
        set -l remaining (math "$deny - $attempts")

        if test $remaining -eq 1
            echo "Осталась попытка: 1"
        else
            echo "Осталось попыток: $remaining"
        end

        return
    end

    set -l last_epoch (date -d "$result[2] $result[3]" +%s 2>/dev/null)
    set -l now (date +%s)
    set -l remaining (math "$last_epoch + $unlock_time - $now")

    if test $remaining -gt 0
        set -l minutes (math "floor($remaining / 60)")
        set -l seconds (math "$remaining % 60")

        echo "Статус: ЗАБЛОКИРОВАН"
        printf "До разблокировки: %d мин %02d сек\n" $minutes $seconds
    else
        echo "Статус: блокировка должна уже закончиться"
    end
end
