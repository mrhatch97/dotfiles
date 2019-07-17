#
# /etc/bash.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

[[ $DISPLAY ]] && shopt -s checkwinsize

# Bash main prompt for root and non-root respectively
if [[ ${EUID} == 0 ]] ; then
    # [time host: wd] h$ >
    PS1='\[\e[31m\][\t \H: \W]\[\e[0m\] \[\e[34m\]\!\$\[\e[0m\] > '
else
    # [user@host: wd] h$ >
    PS1='[\[\e[32m\]\u@\h:\[\e[0m\] \[\e[33m\]\W\[\e[0m\]] \[\e[35m\]\!\$\[\e[0m\] > '
fi

case ${TERM} in
  xterm*|rxvt*|Eterm|aterm|kterm|gnome*)
    PROMPT_COMMAND=${PROMPT_COMMAND:+$PROMPT_COMMAND; }'printf "\033]0;%s@%s:%s\007" "${USER}" "${HOSTNAME%%.*}" "${PWD/#$HOME/\~}"'

    ;;
  screen*)
    PROMPT_COMMAND=${PROMPT_COMMAND:+$PROMPT_COMMAND; }'printf "\033_%s@%s:%s\033\\" "${USER}" "${HOSTNAME%%.*}" "${PWD/#$HOME/\~}"'
    ;;
esac

[ -r /usr/share/bash-completion/bash_completion   ] && . /usr/share/bash-completion/bash_completion

# ls aliases
alias ls='ls -h --color=auto'
alias la='ls -A'
alias ll='la -lv --group-directories-first'

#History alias
alias h='history'

# Always make parent directories when needed, prompt before clobbering files
alias mkdir='mkdir -p'
alias cp='cp -i'
alias mv='mv -i'

# Make grep use colors
alias grep='grep --color=auto'
