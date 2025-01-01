#/!bin/bash
    # Detect if secondary monitor is connected, if so, add a specific bar and move tray to it
    # Else, keep tray on main monitor
    # see https://github.com/polybar/polybar/issues/763

    killall -q polybar

    # Wait until the processes have been shut down
    while pgrep -u $UID -x polybar > /dev/null; do sleep 1; done

    outputs=$(xrandr --query | grep " connected" | cut -d" " -f1)
    set -- $outputs
    tray_output=$1

    	for m in $outputs; do
    		if [ $m == $1 ] 
    		then		
    			MONITOR1=$m polybar --reload mainbar-i3 -c ~/.config/polybar/i3config &	
    		elif [ $m == $2 ]
    		then
    		    tray_output=$m
    			MONITOR2=$m polybar --reload extra-i3 -c ~/.config/polybar/i3config &
    		else
    			MONITOR1=$m polybar --reload mainbar-i3 -c ~/.config/polybar/i3config &
    	  fi
    	done

      for m in $outputs; do
      	export MONITOR1=$1
      	export MONITOR2=$2
       	export TRAY_POSITION=none
        if [[ $m == $tray_output ]]; then
           TRAY_POSITION=right
      fi
    done
