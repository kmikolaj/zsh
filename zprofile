# no beeping
if [[ ! $TERM =~ "screen" ]]; then
	setterm -blength 0
	setterm -bfreq 0
fi

# vim: set ai noet ts=4 sts=4 sw=4 ft=zsh:
