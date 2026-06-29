export ZSH="$HOME/.oh-my-zsh"

ZSH_THEME="ys"
plugins=(git)

if [ -r "$ZSH/oh-my-zsh.sh" ]; then
	source "$ZSH/oh-my-zsh.sh"
fi

[ -f "$HOME/.fzf.zsh" ] && source "$HOME/.fzf.zsh"
source "$HOME/.shellrc"
