## PS1 STUFF ##
function __git_ps1
{
  	local repo_name=$(git symbolic-ref --short HEAD 2>/dev/null)
   	local red="$(tput setaf 1)"
   	local white="$(tput setaf 15)"
   	if [[ -n $repo_name ]]
     	then
   		echo "$white[$red$repo_name$white]"
   	fi
}
function __set_ps1
{
  	local green="\[$(tput setaf 2)\]"
   	local purple="\[$(tput setaf 5)\]"
   	local white="\[$(tput setaf 15)\]"
   	local blue="\[$(tput setaf 6)\]"
   	local SSH=""
  	if [ -n "$SSH_CLIENT" ] || [ -n "$SSH_TTY" ] || [ -n "$SSH_CONNECTION" ]; then
   		SSH="$white[${blue}SSH${white}]"
   	fi
  	PS1="$white\n┌[$green\w$white]${SSH}"'$(__git_ps1)'"$white\n└[$purple\h$white]> "
}
__set_ps1
unset -f __set_ps1

alias v='nvim'
alias wincd="cd /mnt/c/Users/Christian"
#Cross Compiling Aliases

alias cb='cargo build'
deploy_rust () {
  local PURPLE='\033[0;35m'
  local GREEN='\033[0;32m'
  local RED='\033[0;31m'
  local YELLOW='\033[1;33m'
  local NC='\033[0m' # No Color
  echo -e "${RED}Deploying ${YELLOW}$3 ${NC}to ${PURPLE}$1${NC}:${GREEN}$2${NC}"
  scp target/arm-unknown-linux-gnueabi/debug/$3 $1:$2
}
alias cbpi='cargo build --target=arm-unknown-linux-gnueabi && deploy_rust clockworks@monk /home/monk/bin';
# Add raspberry pi to /etc/hosts
echo "192.168.0.24 monk" >> /etc/hosts
source /opt/ros/lunar/setup.sh
export PATH="$HOME/.cargo/bin:$PATH"
