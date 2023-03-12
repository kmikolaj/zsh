# no beeping
if [[ ! $TERM =~ "screen" ]]; then
	setterm -blength 0
	setterm -bfreq 0
fi
