# hostname shodan

# Qt HiDPI
export QT_AUTO_SCREEN_SCALE_FACTOR=0
export QT_ENABLE_HIGHDPI_SCALING=0

# Qt platform
if which qt6ct &> /dev/null; then
	export QT_QPA_PLATFORMTHEME=qt6ct
elif which qt5ct &> /dev/null; then
	export QT_QPA_PLATFORMTHEME=qt5ct
fi

# toolchain directory
export LOCAL_TOOLCHAIN_PATH=${HOME}/virt/rg/toolchain

update() {
	local package=${1}
	local workdir=/tmp
	[ -z ${package} ] && return 1
	[ -d ${workdir} ] || return 1
	pushd ${workdir} && yay -a -f -G ${package} && cd ${package} && makepkg -firsC && popd
}
