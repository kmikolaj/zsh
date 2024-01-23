# no beeping
if [[ ! $TERM =~ "screen" ]]; then
	setterm -blength 0
	setterm -bfreq 0
fi

# debuginfod
distro=$(grep -E '^ID=' /etc/os-release | cut -f2 -d'=')
ubuntulike=(pop ubuntu)
archlike=(arch manjaro)

if [[ $(echo ${ubuntulike[@]} | grep -Fw $distro) ]]; then
	export DEBUGINFOD_URLS="https://debuginfod.ubuntu.com"
elif [[ $(echo ${archlike[@]} | grep -Fw $distro) ]]; then
	export DEBUGINFOD_URLS="https://debuginfod.archlinux.org"
	# show latest archlinux.org post
	if [ -x ~/bin/archlinux-last-feed ]; then
		~/bin/archlinux-last-feed
	fi
fi

# freetype
# best
export FREETYPE_PROPERTIES="truetype:interpreter-version=40"
# too boldy
#export FREETYPE_PROPERTIES="truetype:interpreter-version=38 cff:no-stem-darkening=0 autofitter:no-stem-darkening=0"

# vim: set ai noet ts=4 sts=4 sw=4 ft=zsh:
