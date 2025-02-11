function rsync_sane() {
	new_args=()
	for i in "${@}"; do
		case "${i}" in
			/)
				i="/"
				;;
			*/)
				i="${i%/}"
				;;
		esac
		new_args+=("${i}")
	done
	rsync "${new_args[@]}"
}

# completions
compdef _rsync rsync_sane

alias rsync="rsync_sane"
alias rsync-copy="rsync -avz --progress -h"
alias rsync-move="rsync -avz --progress -h --remove-source-files"
alias rsync-update="rsync -avzu --progress -h"
alias rsync-synchronize="rsync -avzu --delete --progress -h"
