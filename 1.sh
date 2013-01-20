#!/bin/bash
function list {
	IFS=$'\n'
	array=($(ls -1 *.txt ))
	len=${#array[*]}
	echo "Text files in this dir:"
	for (( i=0; i<len; i++ ))
	do
		let j=$i+1
		echo "$j. ${array[$i]}"
	done
	echo
	}
while [ "$input" != "q" ]
do
	list
	echo "Type number of file to show or 'q' to exit:"
	read input
	let j=$input-1
	if [[ "$input" =~ ^[0-9]+$ ]] && [ "$input" -gt 0 ] && [ "$input" -le $len ] 
	then
		head "${array[$j]}"
	elif [ "$input" != "q" ]
	then
		echo "Wrong input"
	fi
	echo
done
echo "Bye!"