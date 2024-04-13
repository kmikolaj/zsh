# Alias
alias grep='grep --color=auto'
alias cgrep='grep --color=always'
alias egrep='grep -E'
alias fgrep='grep -F'
alias hgrep="fc -El 0 | grep"
alias sgrep='grep -I -R -n -H -C 5 --exclude-dir={.git,.svn,CVS}'

if which exa &> /dev/null; then
	alias ls='exa -g -F --group-directories-first'
	alias ll='ls -l'
	alias la='ll -a'
	alias lt='ll -s modified'
	alias lz='ll -s size'
	alias lx='ll -s extension'
else
	alias ls='ls -T0 --color -v -F -N -h --group-directories-first'
	alias ll='ls -l'
	alias la='ll -A'
	alias lt='ll -rt'                   # sort by modified
	alias lz='ll -rS'                   # sort by size
	alias lx='ll -X'                    # sort by extension
fi
alias lr='ls -R'                        # recursive ls
alias lm='la | less -RFe'
alias open='xdg-open'
alias unexport='unset'
alias dir='ls'
alias diff='colordiff -s'
#alias rm='rm -vI'
alias ln='ln -i'
alias h='history'
alias p='ps -f'
alias wget='wget -c'
alias wgetimages='wget -nd -r -l 2 -A jpg,jpeg,png,gif,bmp'
alias cp='cp -i'
alias mv='mv -i'
alias dud='du -h --max-depth=1 | sort -k 1,1hr -k 2,2f'
alias duf='du -s ./* | sort -nr | cut -f 2- | xargs -i du -sh {}'
alias du='du -h'
alias df='df -h'
alias cal='cal -m'
alias cd..='cd ..'
alias su='su -l'
alias crontab='crontab -i'
alias feh='feh --keep-zoom-vp --auto-rotate'
alias '..'='cd ..'
alias -g ...='../..'
alias -g ....='../../..'
alias -g .....='../../../..'
alias nvim='nvim -p'
alias vim='nvim'
alias vimdiff='nvim -O -d'
alias rvim='nvim -Z'
alias vi='vim'
alias gvim='nvim-qt -- -p'
alias gdb='gdb -q'
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
alias dd='dd status=progress'
alias zip='zip -y'
alias wl-copy='wl-copy -n'
alias ffplay='ffplay -autoexit -nodisp -loglevel 8'
alias atmux='tmux new-session -A -s'
# search
alias ff='fd -t file -g'
alias fdi='fd --no-ignore-vcs'
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
alias -g LL="2>&1 |less"
alias -g T="|tail"
alias -g H="|head"
alias -g G="|cgrep"
alias -g B="|bat --paging=always"
alias -g S="|sort"
alias -g SU="|sort -u"
alias -g SN='|sort -n -r'
alias -g N="&>/dev/null"
alias -g NE="2>/dev/null"
alias -g C="|column -t"
alias -g CA="2>&1 |bat -A"
alias -g TEE="2>&1 |tee"

# Suffix alias
alias -s log="tail -f"

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
