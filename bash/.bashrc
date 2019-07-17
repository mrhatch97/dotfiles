#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# Color definitions:
red='\e[0;31m'
RED='\e[1;31m'
blue='\e[0;34m'
BLUE='\e[1;34m'
cyan='\e[0;36m'
CYAN='\e[1;36m'
NC='\e[0m'              # No Color

#Truncate working dir to last 20 characters
if [ -z "$COLUMNS" ] 
then
    COLUMNS=80
fi
NEW_PROMPT_COMMAND='TRIMMED_PWD=${PWD: -($COLUMNS / 4)}; TRIMMED_PWD=${TRIMMED_PWD:-$PWD}'

#-------------------------------------------------------------------------------
# Personal Aliases
#-------------------------------------------------------------------------------

alias vi='vim'

mkdcd() 
{
    mkdir "$1" && cd "$1"
}

# Filecount
alias fc='ll | wc -l'

# Flush terminal buffer
alias clearf="clear && printf '\e[3J'"

# Laziness
shopt -s autocd
alias cd..='cd ..'

# Print paths in a less gross way
alias path='echo -e ${PATH//:/\\n}'

# Make du and df more friendly
alias du='du -kh'
alias df='df -kTh'

alias duh='du -d 1'

#-------------------------------------------------------------------------------
# Environment Variables
#-------------------------------------------------------------------------------
export GPG_TTY=$(tty)

# Start the gpg-agent if not already running
if ! pgrep -x -u "${USER}" gpg-agent >/dev/null 2>&1; then
  gpg-connect-agent /bye >/dev/null 2>&1
fi

# Refresh gpg-agent tty in case user switches into an X session
gpg-connect-agent updatestartuptty /bye >/dev/null

# Avoid clobbering the existing prompt command
if [ -n "$PROMPT_COMMAND" ]; then 
    PROMPT_COMMAND="$PROMPT_COMMAND;$NEW_PROMPT_COMMAND"
else
    PROMPT_COMMAND="$NEW_PROMPT_COMAND"
fi

# Done with this
unset NEW_PROMPT_COMMAND

# Bash main prompt for root and non-root respectively
if [[ ${EUID} == 0 ]] ; then
    PS1='\[\e[31m\][\t \H: $TRIMMED_PWD] \!\$ > \[\e[0m\]'
    #Optional multiline prompt
    #PS1='\[\e[31m\]\n\h: [\w] \t\n\!\$ > \[\e[0m\]'
else
    # [user@host: wd] h$ >
    PS1='[\[\e[32m\]\u@\h:\[\e[0m\] \[\e[33m\]$TRIMMED_PWD\[\e[0m\]] \[\e[35m\]\!\$\[\e[0m\] > '
    # Optional multiline prompt
    # user@host: [wd]
    # h$ >
    #PS1='\[\e[32m\]\u@\h\[\e[0m\]: [\[\e[33m\]\w\[\e[0m\]]\n\[\e[35m\]\!\$\[\e[0m\] > '
fi

# Bash secondary prompt
PS2='>'

if [ -f "$HOME/.bash-git-prompt/gitprompt.sh" ]; then
    GIT_PROMPT_ONLY_IN_REPO=1
    source $HOME/.bash-git-prompt/gitprompt.sh
fi

#-------------------------------------------------------------------------------
# MOTD etc.
#-------------------------------------------------------------------------------

echo -e "Imperial thought for the day:\n$(fortune warhammer)"

#-------------------------------------------------------------------------------
# Personal aliases
#-------------------------------------------------------------------------------
alias install='sudo pacman -S'
alias uninstall='sudo pacman -Rs'

# traverse up the working directory 'to' a given directory
function to() {
    cwd=`pwd`
    cd ${cwd%$1*}$1 
}

# Disable CTRL-s scroll lock
stty -ixon
