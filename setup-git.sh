#!/bin/sh

if [ $# -gt 1 ]; then
	echo "Usage: $0 [profile_name]" >&2
	exit 1
fi

name=${1:-default}

case "$name" in
	''|*[!A-Za-z0-9._-]*)
		echo "Invalid profile name: $name" >&2
		exit 1
		;;
esac

dir_base=$(CDPATH= cd "$(dirname "$0")" && pwd -P) || exit 1
example="$dir_base/.gitprofile.example"
profile="$HOME/.gitprofile.$name"
dispatcher="$HOME/.gitprofile"
profile_tmp=
dispatcher_tmp=

cleanup() {
	[ -z "$profile_tmp" ] || rm -f "$profile_tmp"
	[ -z "$dispatcher_tmp" ] || rm -f "$dispatcher_tmp"
}
trap cleanup 0 HUP INT TERM

if [ ! -f "$example" ]; then
	echo "Missing profile template: $example" >&2
	exit 1
fi

if [ -e "$profile" ] && ! git config --file "$profile" --list >/dev/null; then
	echo "Invalid Git config: $profile" >&2
	exit 1
fi

if [ -e "$dispatcher" ] && ! git config --file "$dispatcher" --list >/dev/null; then
	echo "Invalid Git config: $dispatcher" >&2
	exit 1
fi

has_value() {
	git config --file "$dispatcher" --get-all "$1" 2>/dev/null |
		grep -F -x -q "$2"
}

conditional_keys() {
	git config --file "$dispatcher" --name-only \
		--get-regexp '^include[Ii]f\..*\.path$' 2>/dev/null
}

has_conditional_profile() {
	conditional_keys |
		(
			while IFS= read -r key; do
				has_value "$key" "$profile" && exit 0
			done
			exit 1
		)
}

conditional_gitdirs() {
	conditional_keys |
		while IFS= read -r key; do
			if has_value "$key" "$profile"; then
				value=${key#*gitdir:}
				value=${value%.path}
				printf '%s\n' "$value"
			fi
		done
}

prompt_value() {
	label=$1
	current=$2

	while :; do
		if [ -n "$current" ]; then
			printf '%s [%s]: ' "$label" "$current" >&2
		else
			printf '%s: ' "$label" >&2
		fi

		IFS= read -r input || return 1
		if [ -n "$input" ]; then
			printf '%s' "$input"
			return 0
		fi
		if [ -n "$current" ]; then
			printf '%s' "$current"
			return 0
		fi
		echo "A value is required." >&2
	done
}

if [ "$name" = default ]; then
	if has_conditional_profile; then
		echo "Profile 'default' is already conditional." >&2
		exit 1
	fi
	config_key=include.path
	gitdir=
else
	if has_value include.path "$profile"; then
		echo "Profile '$name' is already unconditional." >&2
		exit 1
	fi
	existing_gitdirs=$(conditional_gitdirs)
fi

profile_tmp=$(mktemp "$HOME/.gitprofile.$name.XXXXXX") || exit 1
if [ -e "$profile" ]; then
	cp "$profile" "$profile_tmp" || exit 1
else
	cp "$example" "$profile_tmp" || exit 1
fi

current_name=$(git config --file "$profile_tmp" --get user.name 2>/dev/null || :)
current_email=$(git config --file "$profile_tmp" --get user.email 2>/dev/null || :)
[ "$current_name" = 'Your Name' ] && current_name=
[ "$current_email" = 'you@example.com' ] && current_email=

user_name=$(prompt_value user.name "$current_name") || exit 1
user_email=$(prompt_value user.email "$current_email") || exit 1

git config --file "$profile_tmp" user.name "$user_name" || exit 1
git config --file "$profile_tmp" user.email "$user_email" || exit 1
chmod 600 "$profile_tmp" || exit 1

if [ "$name" != default ]; then
	if [ -n "$existing_gitdirs" ]; then
		echo "Existing gitdir(s) for '$name':" >&2
		printf '%s\n' "$existing_gitdirs" | sed 's/^/  /' >&2
		printf 'gitdir (empty to keep existing): ' >&2
		IFS= read -r gitdir || exit 1
	else
		while [ -z "$gitdir" ]; do
			printf 'gitdir: ' >&2
			IFS= read -r gitdir || exit 1
			[ -n "$gitdir" ] || echo "A gitdir is required." >&2
		done
	fi

	if [ -n "$gitdir" ]; then
		case "$gitdir" in
			*/) ;;
			*) gitdir="$gitdir/" ;;
		esac
		config_key="includeIf.gitdir:${gitdir}.path"
	else
		config_key=
	fi
fi

rule_exists=false
if [ -n "$config_key" ] && has_value "$config_key" "$profile"; then
	rule_exists=true
fi

if [ -n "$config_key" ] && [ "$rule_exists" = false ]; then
	dispatcher_tmp=$(mktemp "$HOME/.gitprofile.XXXXXX") || exit 1
	if [ -e "$dispatcher" ]; then
		cp "$dispatcher" "$dispatcher_tmp" || exit 1
	fi
	git config --file "$dispatcher_tmp" --add "$config_key" "$profile" || exit 1
	chmod 600 "$dispatcher_tmp" || exit 1
fi

mv -f "$profile_tmp" "$profile" || exit 1
profile_tmp=

if [ -n "$dispatcher_tmp" ]; then
	mv -f "$dispatcher_tmp" "$dispatcher" || exit 1
	dispatcher_tmp=
fi

if [ "$name" = default ]; then
	echo "Configured default Git profile."
elif [ -n "$gitdir" ]; then
	echo "Configured Git profile '$name' for $gitdir"
else
	echo "Updated Git profile '$name'."
fi
