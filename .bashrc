## PS1 STUFF ##
function __git_ps1
{
  	local repo_name=$(git symbolic-ref --short HEAD 2>/dev/null)
   	local red="$(tput setaf 1)"
   	local white="$(tput setaf 7)"
   	if [[ -n $repo_name ]]
     	then
   		echo "─[$red$repo_name$white]"
   	fi
}
function __set_ps1
{
  	local green="\[$(tput setaf 2)\]"
   	local purple="\[$(tput setaf 5)\]"
   	local white="\[$(tput setaf 7)\]"
   	local blue="\[$(tput setaf 6)\]"
   	local SSH=""
  	if [ -n "$SSH_CLIENT" ] || [ -n "$SSH_TTY" ] || [ -n "$SSH_CONNECTION" ]; then
   		SSH="─[${blue}SSH${white}]"
   	fi
  	PS1="\n┌─[$green\w$white]${SSH}"'$(__git_ps1)'"\n└─[$purple\h$white]> "
}
__set_ps1
unset -f __set_ps1
