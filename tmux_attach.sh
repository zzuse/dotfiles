#!/bin/bash
# abort if we're already inside a TMUX session
[ "$TMUX" == "" ] || exit 0
# startup a "default" session if non currently exists
# tmux has-session -t _default || tmux new-session -s _default -d
tmux -V
# present menu for user to choose which workspace to open
PS3="Please choose your session: "
options=($(tmux list-sessions -F "#S" 2>/dev/null))
if [ -z "$options" ]; then
   	tmux set-option -g history-limit 50000 \; new-session -s zz
       	#tmux new-session -s "$1" -n ide \; split-window -v -p 20 -t "$1" \; select-pane -t 1 \; clock-mode \; split-window -h -p 80 -t "$1" \;
else
        #options=($(tmux list-sessions -F "#S" 2>/dev/null) "New Session" "zsh")
	echo "Available sessions"
	echo "------------------"
	echo " "
	select opt in "${options[@]}"
	do
		case $opt in
			*)
				tmux attach-session -t $opt
				break
				;;
		esac
	done
fi

