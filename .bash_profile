export CLICOLOR=1
export LSCOLORS=ExFxCxDxBxegedabagacad
export FZF_DEFAULT_OPTS="--color fg:252,bg:233,hl:67,fg+:252,bg+:235,hl+:81 --color info:144,prompt:161,spinner:135,pointer:135,marker:118"
export FZF_DEFAULT_COMMAND='ag --hidden --ignore .git -g ""'

alias :q='exit'
alias cls='clear'
alias cd2='cd ../../'
alias cd3='cd ../../../'

if [ `uname` = "Darwin" ]; then
	alias ll='ls -al'
else
	alias ll='ls -al --color'
fi

