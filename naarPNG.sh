#!/bin/bash

for i in $(find $1 -name "*.jpg")
do
	input="${i%.jpg}.png"

	width=`identify -ping -format %w $i`
	height=`identify -ping -format %h $i`

	if [ width > 128 ] || [ height > 128  ] ; then
		convert "$i" -resize 128x128 "$input"
		echo "converted and resized $i to $input"
	else
		convert "$i" "$input"
		echo "converted $i to $input"

	fi

done
