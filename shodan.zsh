# hostname shodan

# toolchain directory
export LOCAL_TOOLCHAIN_PATH=${HOME}/virt/rg/toolchain

update() {
	local package=${1}
	local workdir=/tmp
	[ -z ${package} ] && return 1
	[ -d ${workdir} ] || return 1
	pushd ${workdir} && yay -a -f -G ${package} && cd ${package} && makepkg -firsC && popd
}
