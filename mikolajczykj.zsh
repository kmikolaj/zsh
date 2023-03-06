# hostname mikolajczykj

# less highlight
export LESSOPEN='|/usr/bin/lesspipe %s'

# toolchain directory
export LOCAL_TOOLCHAIN_PATH=${HOME}/tools/toolchains/cmake
export LOCAL_COMPILER_PATH=${HOME}/tools/toolchains/gcc

# distcc
export DISTCC_DIR=/tmp/distcc

# alias
alias update='sudo apt update && sudo apt upgrade && sudo apt autoremove'
