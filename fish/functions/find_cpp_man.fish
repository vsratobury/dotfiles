function find_cpp_man --description 'Find manuals for C++ language'

set -l manpath $HOME/.local/man/man3/

  if test -n "$argv"
    fd .3.gz $manpath | sed 's/^.*\///;s/.3.gz$//' | eval (__fzfcmd) --query $argv | sed 's/(.*)//g;s/<.*>//g;s/,.*$//'
  else
    fd .3.gz $manpath | sed 's/^.*\///;s/.3.gz$//' | eval (__fzfcmd) | sed 's/(.*)//g;s/<.*>//g;s/,.*$//'
  end

end
