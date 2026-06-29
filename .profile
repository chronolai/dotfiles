export FZF_DEFAULT_OPTS='--color fg:252,bg:233,hl:67,fg+:252,bg+:235,hl+:81 --color info:144,prompt:161,spinner:135,pointer:135,marker:118'
export FZF_DEFAULT_COMMAND='ag --hidden --ignore .git -g ""'

case "$(uname -s)" in
	Darwin)
		export CLICOLOR=1
		export LSCOLORS=ExFxCxDxBxegedabagacad

		if [ -x /opt/homebrew/bin/brew ]; then
			eval "$(/opt/homebrew/bin/brew shellenv)"
		elif [ -x /usr/local/bin/brew ]; then
			eval "$(/usr/local/bin/brew shellenv)"
		fi
		;;
	Linux)
		;;
esac

. "$HOME/.local/bin/env"
