# Alias
alias grep='grep --color=auto'
alias cgrep='grep --color=always'
alias egrep='grep -E'
alias fgrep='grep -F'

if which exa &> /dev/null; then
	alias ls='exa -g -F --group-directories-first'
	alias ll='ls -l'
	alias la='ll -a'
	alias lt='ll -rt modified'
else
	alias ls='ls --color -v -F -N -h --group-directories-first'
	alias ll='ls -l'
	alias la='ll -A'
	alias lt='ll -rt'
fi
alias lr='ls -R'                    # recursive ls
alias lx='ll -BX'                   # sort by extension
alias lz='ll -rS'                   # sort by size
alias lm='la | more'
alias open='xdg-open'
alias dir='ls'
alias diff='colordiff -s'
#alias rm='rm -vI'
alias ln='ln -i'
alias wget='wget -c'
alias wgetimages='wget -nd -r -l 2 -A jpg,jpeg,png,gif,bmp'
alias cp='cp -i'
alias mv='mv -i'
alias dud='du -h --max-depth=1 | sort -k 1,1hr -k 2,2f'
alias duf='du -s ./* | sort -nr | cut -f 2- | xargs -i du -sh {}'
alias df='df -h'
alias cal='cal -m'
alias cd..='cd ..'
alias su='su -'
alias feh='feh --keep-zoom-vp --auto-rotate'
alias '..'='cd ..'
alias -g ...='../..'
alias -g ....='../../..'
alias -g .....='../../../..'
alias nvim='nvim -p'
alias vim='nvim'
alias vi='vim'
alias gvim='nvim-qt -- -p'
alias hex='od -Ax -tx1'
alias nano='micro'
alias dmesg='dmesg -e'
alias makebackup='rsync -rlptv --delete --stats ~/backup/ ~/dropbox/Linux'
alias beep='echo -e '''
alias httpshare='python3 -m http.server 8080'
alias sxiv='sxiv -a'
alias hexyl='hexyl --color=auto --border=none'
#alias subdl='subdl -i --filter --lang=pol,eng'
alias subdl='subdl -i --lang=pol,eng'
alias stig='tig -10000'
alias dd='dd status=progress'
alias zip='zip -y'
alias wl-copy='wl-copy -n'
alias ffplay='ffplay -autoexit -nodisp -loglevel 8'
# net-tools
alias ifconfig='ip addr show'
alias route='ip route show'
alias netstat='ss -atu'
alias arp='ip neigh'
alias ping='ping -O'
# silver searcher is ripgrep
alias rgi='rg --no-ignore-vcs'
alias ag=rg
alias agi=rgi
# arch
alias yay='yay --sudoflags -B'
alias aurupdate='yay --sudoloop -Sua'
alias pacsize="expac -HM '%m\t%n' | column -t | sort -h"
alias orphans='pacman -Qdt'
alias abs=asp

# Global alias
alias -g L="|less"
alias -g T="|tail"
alias -g H="|head"
alias -g G="|cgrep"
alias -g S="|sort"
alias -g U="|sort -u"
alias -g N="&>/dev/null"
alias -g C="|column -t"

# Common typos
alias sl='ls'
alias vf='cd'

# Debian-like only
if grep ID_LIKE /etc/*release | grep debian &> /dev/null; then
	alias bat=batcat
	alias fd=fdfind
fi

# Wayland compatibility alias
if [ ! -z $WAYLAND_DISPLAY ]; then
	alias xsel=wl-copy
fi
