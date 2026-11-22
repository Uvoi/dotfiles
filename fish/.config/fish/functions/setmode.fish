function setmode

    switch $argv[1]

        case perf performance
            echo "🔥 PERFORMANCE mode"

            sudo tlp performance

            # FORCE CPU EPP
            for cpu in /sys/devices/system/cpu/cpu*/cpufreq/energy_performance_preference
                echo performance | sudo tee $cpu > /dev/null
            end

            # FORCE PLATFORM PROFILE
            echo performance | sudo tee /sys/firmware/acpi/platform_profile > /dev/null

            echo "✔ PERF active"

        case bal balance balanced
            echo "⚖️ BALANCED mode"

            sudo tlp balanced

            for cpu in /sys/devices/system/cpu/cpu*/cpufreq/energy_performance_preference
                echo balance_performance | sudo tee $cpu > /dev/null
            end

            echo balanced | sudo tee /sys/firmware/acpi/platform_profile > /dev/null

            echo "✔ BAL active"

        case eco power saver powersave
            echo "🔋 POWER SAVER mode"

            sudo tlp power-saver

            for cpu in /sys/devices/system/cpu/cpu*/cpufreq/energy_performance_preference
                echo power | sudo tee $cpu > /dev/null
            end

            echo "✔ ECO active"

        case '*'
            echo "Usage: setmode perf | bal | eco"
            return 1
    end

    echo "────────────────────────────"
    tlp-stat -s | grep "Power profile"
    cat /sys/devices/system/cpu/cpu0/cpufreq/energy_performance_preference
end
