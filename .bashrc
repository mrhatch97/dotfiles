#
# .bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

[[ $DISPLAY ]] && shopt -s checkwinsize

case ${TERM} in
  xterm*|rxvt*|Eterm|aterm|kterm|gnome*)
    PROMPT_COMMAND=${PROMPT_COMMAND:+$PROMPT_COMMAND; }'printf "\033]0;%s@%s:%s\007" "${USER}" "${HOSTNAME%%.*}" "${PWD/#$HOME/\~}"'

    ;;
  screen*)
    PROMPT_COMMAND=${PROMPT_COMMAND:+$PROMPT_COMMAND; }'printf "\033_%s@%s:%s\033\\" "${USER}" "${HOSTNAME%%.*}" "${PWD/#$HOME/\~}"'
    ;;
  linux*)
    PROMPT_COMMAND=${PROMPT_COMMAND:+$PROMPT_COMMAND; }'printf "\033]0;%s@%s:%s\007" "${USER}" "${HOSTNAME%%.*}" "${PWD/#$HOME/\~}"'
    ;;
esac

[ -r /usr/share/bash-completion/bash_completion   ] && . /usr/share/bash-completion/bash_completion

# Color definitions:
red='\e[0;31m'
RED='\e[1;31m'
blue='\e[0;34m'
BLUE='\e[1;34m'
cyan='\e[0;36m'
CYAN='\e[1;36m'
NC='\e[0m'              # No Color

#-------------------------------------------------------------------------------
# Functions etc.
#-------------------------------------------------------------------------------

#Truncate working dir to last 20 characters

if [ -z "$COLUMNS" ] 
then
    COLUMNS=80
fi
NEW_PROMPT_COMMAND='TRIMMED_PWD=${PWD: -($COLUMNS / 4)}; TRIMMED_PWD=${TRIMMED_PWD:-$PWD}'

#-------------------------------------------------------------------------------
# Personal Aliases
#-------------------------------------------------------------------------------

# ls aliases
alias ls='ls -h --color=auto'
alias la='ls -A'
alias ll='la -lv --group-directories-first'

alias h='history'

# Always make parent directories when needed, prompt before clobbering files
alias mkdir='mkdir -p'
alias cp='cp -i'
alias mv='mv -i'

# No vi
alias vi='vim'

function mkdcd() 
{
    mkdir "$1" && cd "$1"
}

function to() {
    cwd=`pwd`
    cd ${cwd%$1*}$1 
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

# Make grep use colors
alias grep='grep --color=auto'

#-------------------------------------------------------------------------------
# Environment Variables
#-------------------------------------------------------------------------------

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
    PS1='[\u@\h: $TRIMMED_PWD] \!\$ > '
    #Optional multiline prompt
    #PS1='\n\u@\h: [\w]\n\!\$ > '
fi

# Bash secondary prompt
PS2='>'

#-------------------------------------------------------------------------------
# MOTD etc.
#-------------------------------------------------------------------------------

echo -e "Bash version ${RED}${BASH_VERSION%.*}${NC} on tty ${RED}$DISPLAY${NC} at $(date +%Y-%m-%d:%H:%M:%S)"
