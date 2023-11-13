take() {
	mkdir -p $@ && cd ${@:$#}
}

# Wireshark remote capture
capture() {
	local host=${1}
	local port=${2-22}
	ssh ${host} /usr/sbin/tcpdump -U -s0 -w - "not port ${port}" | wireshark -k -i -
}

# Bzipping
pack() {
	if [ -n "$1" ]; then
		dir=$(dirname "$1")
		file=$(basename "$1")

		if [ -d "$dir/$file" ]; then
			tar cvfj "$file.tar.bz2" "$dir/$file"
		elif [ -f "$dir/$file" ]; then
			tar cvfj "${file%.*}.tar.bz2" "$dir/$file"
		else
			echo "Archive not created." && return 1
		fi
	fi
}

vcspack() {
	if [ -n "$1" ]; then
		dir=$(dirname "$1")
		file=$(basename "$1")

		if [ -d "$dir/$file" ]; then
			tar --exclude-vcs-ignores -cvj -f "$file.tar.bz2" "$dir/$file"
		elif [ -f "$dir/$file" ]; then
			tar --exclude-vcs-ignores -cvj -f "${file%.*}.tar.bz2" "$dir/$file"
		else
			echo "Archive not created." && return 1
		fi
	fi
}

# Ultimate archive unpacker
unpack() {
	if [ -f $1 ]; then
		case $1 in
			*.tar.bz2)       tar xvjf $1         ;;
			*.tar.gz)        tar xvzf $1         ;;
			*.tar.xz)        tar xvJf $1         ;;
			*.tar.zst)       tar -I zstd -xvf $1 ;;
			*.bz2)           bunzip2 $1          ;;
			*.[rR][aA][rR])  unrar x $1          ;;
			*.gz)            gunzip $1           ;;
			*.tar)           tar xvf $1          ;;
			*.tbz2)          tar xvjf $1         ;;
			*.tgz)           tar xvzf $1         ;;
			*.[zZ][iI][pP])  unzip $1            ;;
			*.Z)             uncompress $1       ;;
			*.7z)            7z x $1             ;;
			*.xz)            xz -d $1            ;;
			*)               echo "File '$1' can't be unpacked." ;;
		esac
	else
		echo "'$1' is not an archive format."
	fi
}

# hexstring to binary stream
hextostr() {
	echo -n $* | xxd -p -r
}

# binary diff
bindiff() {
	diff -y <(xxd "$1") <(xxd "$2") | colordiff
}

update() {
	local package=${1}
	local workdir=/tmp
	[ -z ${package} ] && return 1
	[ -d ${workdir} ] || return 1
	pushd ${workdir} && yay -a -f -G ${package} && cd ${package} && makepkg -firsC && popd
}

ssh-copy-key() {
	local destination=$1
	[ -z ${destination} ] && return 1
	cat ${HOME}/.ssh/id_rsa.pub | ssh "$destination" "mkdir -p ~/.ssh; cat >> ~/.ssh/authorized_keys"
}

is-remote-session() {
	if [ -n "$SSH_CLIENT" ] || [ -n "$SSH_TTY" ]; then
		return 0
	fi

	case $(ps -o comm= -p "$PPID") in
		sshd|*/sshd) return 0;;
	esac

	return 1
}
