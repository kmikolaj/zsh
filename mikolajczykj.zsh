# hostname mikolajczykj

# less highlight
export LESSOPEN='|/usr/bin/lesspipe %s'

# toolchain directory
export LOCAL_TOOLCHAIN_PATH=${HOME}/tools/toolchains/cmake
export LOCAL_COMPILER_PATH=${HOME}/tools/toolchains/gcc

# distcc
export DISTCC_DIR=/tmp/distcc

# mc
export MC_SKIN=$HOME/.config/mc/skin/solarized.ini

# HiDPI Qt
export QT_AUTO_SCREEN_SCALE_FACTOR=1
export QT_ENABLE_HIGHDPI_SCALING=1
#export QT_SCREEN_SCALE_FACTORS="HDMI-A-0=1;DisplayPort-0=1.5"
#export QT_SCREEN_SCALE_FACTORS="HDMI-1=1;DP-1=1.5"

# Wayland
if [ ! -z $WAYLAND_DISPLAY ]; then
	#export QT_QPA_PLATFORM=wayland-egl
	export QT_QPA_PLATFORM=wayland
	export GDK_BACKEND=wayland
	export MOZ_ENABLE_WAYLAND=1
	export MOZ_WEBRENDER=1
fi

# alias
alias update='sudo apt update && sudo apt full-upgrade && sudo apt autoremove --purge'
alias vnc6000='vncviewer -PasswordFile=$HOME/.vnc/passwd'

# Wireshark remote capture
capture() {
	local host=${1}
	local port=${2-22}
	local interface=${3-eth0}
	if [[ ${interface} =~ can[0-9]* ]]; then
		ssh -oKexAlgorithms=+diffie-hellman-group1-sha1 ${host} -p ${port} /usr/sbin/tcpdump -i ${interface} -U -s0 -w - | wireshark -k -i -
	else
		ssh -oKexAlgorithms=+diffie-hellman-group1-sha1 ${host} -p ${port} /usr/sbin/tcpdump -i ${interface} -U -s0 -w - "not port ${port}" | wireshark -k -i -
	fi
}

