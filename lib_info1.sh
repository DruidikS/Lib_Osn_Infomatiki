#!/bin/bash

declare -a temperatures

cels_to_F() {
    	c="$1"
    	echo "scale=2; ($c * 9 / 5) + 32" | bc
}

F_to_cels() {
    	f="$1"
    	echo "scale=2; ($f - 32) * 5 / 9" | bc
}

add_temperature() {
	echo "Enter programm:"
    	echo "1  Cels"
    	echo "2  F"
    	read -p "programma 1 or 2 " scale

	if [ "$scale" -ne 1 ] && [ "$scale" -ne 2 ]
	then
		echo "Please enter 1 or 2"
        	return
    	fi

    	read -p "Enter value " value
	temperatures+=("$value$scale")
}

show_in_cels() {
	echo "All temperature in cels"

    	for item in "${temperatures[@]}"
	do
        	num="${item%?}"
        	scale="${item: -1}"

        	if [ "$scale" -eq 1 ]
		then
            		echo "$num"
        	else
            		f="$(F_to_cels $num)"
            		echo "$f"
        	fi
    	done
}

show_in_F() {
	echo "All temperatures in F"

    	for item in "${temperatures[@]}"
	do
        	num="${item%?}"
       		scale="${item: -1}"

        	if [ "$scale" -eq 2 ]
		then
            		echo "$num"
        	else
            		cels="$(cels_to_F $num)"
            		echo "$cels"
        	fi
    	done
}

while true
do
    	echo "1  add temp"
    	echo "2  show in cels"
    	echo "3  show in F"
    	echo "4  Exit"

    	read -p "Enter programm " choice

    	case "$choice" in
        	1) add_temperature ;;
        	2) show_in_cels ;;
        	3) show_in_F ;;
        	4) break ;;
        	*) echo "Not such programm" ;;
    	esac
done