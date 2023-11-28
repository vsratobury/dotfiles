function fish_right_prompt
    # show jobs count
    set -l jobs_count (jobs --pid | count)
    if test $jobs_count -gt 0
        set_color red
        echo "[" $jobs_count "]"
    end

    # show date and time
    # set_color white
    # echo "< "
    # echo (date '+%H:%M')" "

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
