#!/bin/bash

status=$?
set_date=$(date)
set_time=$(date +%H:%M:%S)

echo "Logged at $set_date" > log.txt

for i in $(find $1)
do
	if $2 "$i" > /dev/null; then
		echo "[$set_time] - $2 $i - Geslaagd" >> log.txt
	else
		echo "[$set_time]  - $2 $i - Niet geslaagd" >> log.txt
	fi

done

echo "Ran '$2' command with exit status: $status"
