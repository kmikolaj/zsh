# no beeping
if [[ ! $TERM =~ "screen" ]]; then
	setterm -blength 0
	setterm -bfreq 0
fi

# debuginfod
distro=$(grep -E '^ID=' /etc/os-release | cut -f2 -d'=')
ubuntulike=(pop ubuntu)
archlike=(arch manjaro)

if [[ ${ubuntulike[(r)$distro]} == $distro ]]; then
	export DEBUGINFOD_URLS="https://debuginfod.ubuntu.com"
elif [[ ${archlike[(r)$distro]} == $distro ]]; then
	export DEBUGINFOD_URLS="https://debuginfod.archlinux.org"
fi

# vim: set ai noet ts=4 sts=4 sw=4 ft=zsh:
