# fzf
function find_fzf_files() {
	local fzf_base
	local potential_dirs=(
		/usr/share/fzf
		/usr/share/doc/fzf/examples
	)

	for dir in ${potential_dirs}; do
		if [[ -d "${dir}" ]]; then
			fzf_base="${dir}"
			break
		fi
	done

	if [[ ! -d "${fzf_base}" ]]; then
		return 1
	fi

	[ -f "${fzf_base}/key-bindings.zsh" ] && source "${fzf_base}/key-bindings.zsh"
	[ -f "${fzf_base}/completion.zsh" ] && source "${fzf_base}/completion.zsh"
}

if (( $+commands[fd] )); then
	export FZF_DEFAULT_COMMAND='fd --type f --hidden --exclude .git'
elif (( $+commands[rg] )); then
	export FZF_DEFAULT_COMMAND='rg --files --hidden --glob "!.git/*"'
elif (( $+commands[ag] )); then
	export FZF_DEFAULT_COMMAND='ag -l --hidden -g "" --ignore .git'
fi
export FZF_DEFAULT_OPTS='--height 40% --layout=reverse'

find_fzf_files
