#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

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

function prompt_command {
    export PS1=$(bash_prompt $?)
}

export PROMPT_COMMAND=prompt_command

# Bash secondary prompt
PS2='>'

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

    if [ "`basename "$cwd"`" == "$1" ]; then
        cwd="`dirname "$cwd"`"
    fi

    newwd="${cwd%$1*}"

    if [ "$newwd" == "$cwd" ]; then
        echo "No such directory"; 
        return 1
    else
        cd "$newwd"/"$1"
    fi
}

# Disable CTRL-s scroll lock
stty -ixon
