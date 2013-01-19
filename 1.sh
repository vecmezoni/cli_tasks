#!/bin/bash

function list {
	IFS='
'
	i=0
	array=(`ls`)
	len=${#array[*]}
	echo "Text files inside this directory:"
	while [ $i -lt $len ]
	do
		let "j=$i+1"
		echo "$j. ${array[$i]}"
		let "i++"
	done
	IFS=$OIFS
	echo ""
	}
input='0'
while [ "$input" != "q" ]
do
	list
	echo "Type number of file to show or 'q' to exit:"
	read input
	let "j=$input-1"
	if [[ "$input" =~ ^-{0,1}[0-9]+$ ]] && [ "$input" -le 0 ]
	then
		echo "Wrong input"
	elif [[ "$input" =~ ^-{0,1}[0-9]+$ ]] && [ "$input" -gt $len ] 
	then
		echo "Wrong input"
	elif [[ "$input" =~ ^-{0,1}[0-9]+$ ]]
	then
		echo `head "${array[$j]}"`
	elif [ "$input" != "q" ]
	then
		echo "Wrong input"
	fi
	echo ""
done