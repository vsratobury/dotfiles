function cheats
    set log $HOME/.cache/cheats.log
    set url https://cheat.sh/(echo "$argv" | sed 's/\ /+/g')
    set file $TMPDIR/(date '+%d%m%Y')-(echo $argv | sed 's/\//-/g;s/~/-/g;s/:/-/g')-cheats.result

    if not test -f $file; or test (cat $file | wc -l) -eq 0
        printf "cheats: %s: try download %s: " (date -R) $url >> $log
        curl -s $url 1> $file 2>> $log
        if test $status -ne 0
            echo 'fail' >> $log
        else
            echo 'success' >> $log
        end
    end

    set lines (cat $file | wc -l)
    if test $lines -eq 0
        echo 'not found or server error'
    end
    if test $lines -gt $LINES
        cat $file | less -R
    else
        cat $file
    end
end
