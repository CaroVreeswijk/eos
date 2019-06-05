#!/bin/bash

echo "extCount > Counting files in $1"

count=0

for file in "${@:2}"; do
	count=$((count=0))
	for ext in $(find $1); do

		check="*.$file"

		case $ext in
			$check)
				count=$((count+1))
				;;
		esac

	done
	echo "$file: $count"

done

echo "extCount > Done!"
