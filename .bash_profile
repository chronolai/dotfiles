export PATH="$PATH:$HOME/.tmuxifier/bin"
eval "$(tmuxifier init -)"

export CLICOLOR=1
export LSCOLORS=ExFxCxDxBxegedabagacad

alias cls='clear'

if [ `uname` == "Darwin" ]; then
	alias ll='ls -al'
else
	alias ll='ls -al --color'
fi
