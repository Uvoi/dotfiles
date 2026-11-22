function faillock-reset
    set -l user_name $USER

    if test (count $argv) -gt 0
        set user_name $argv[1]
    end

    sudo faillock --user $user_name --reset

    if test $status -eq 0
        echo "Счётчик faillock для $user_name сброшен."
    else
        echo "Не удалось сбросить счётчик faillock."
        return 1
    end
end
