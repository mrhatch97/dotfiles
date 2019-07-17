#
# ~/.bash_profile
#

[[ -f ~/.bashrc ]] && . ~/.bashrc

echo -e "Bash version ${RED}${BASH_VERSION%.*}${NC} on tty ${RED}$DISPLAY${NC} at $(date +%Y-%m-%d:%H:%M:%S)"

export EDITOR=vim
