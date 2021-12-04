function fish_right_prompt
    # show jobs count
    set -l jobs_count (jobs --pid | count)
    if test $jobs_count -gt 1
        set_color red
        echo "jobs: "(math $jobs_count -1)" "
    end

    # show date and time
    set_color white
    echo (date '+%a, %d %b %H:%M')" "

    # battery status
    set -l bat_value (pmset -g batt | grep -Eo "\d+%" | cut -d% -f1)
    set -l bat_time (pmset -g batt | grep -Eo "\d+:\d+")

    # Выбор цвета в зависимости от процентов заряда
    if test $bat_value -lt 25
        set_color yellow
    else if test $bat_value -lt 10
        set_color red
    else
        set_color green
    end

    # print battery status
    if not test -z $bat_time
        echo -n "[$bat_value% | $bat_time]"
    else
        echo -n "[$bat_value%]"
    end
end
