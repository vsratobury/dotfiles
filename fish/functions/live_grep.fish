function live_grep --description 'Grep word in files'
set result (ag $argv --nocolor | eval (__fzfcmd) "$FZF_DEFAULT_OPT")
set file (echo $result | awk -F: '{print $1}')
set str (echo $result | awk -F: '{print $2}')

if test -n "$result"
  nvim "./$file" "+$str"
end

end
