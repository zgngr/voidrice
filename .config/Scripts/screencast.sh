#!/bin/bash

#This is the ffmpeg command that the screencast shortcut in i3 will run.

#Picks a file name for the output file based on availability:

if [[ -f ~/output.mkv ]]
	then
		n=1
		while [[ -f $HOME/output_$n.mkv ]]
		do	
			n=$((n+1))
		done
		filename="$HOME/output_$n.mkv"
	else
		filename="$HOME/output.mkv"
fi

#The actual ffmpeg command:

ffmpeg -y \
-f x11grab \
-s $(xdpyinfo | grep dimensions | awk '{print $2;}') \
-i :0.0 \
-thread_queue_size 1024 \
 -f alsa -ar 44100 -i hw:1 \
-af "volume=12" \
 -c:v libx264 -r 30 -c:a flac $filename
 #-c:v ffvhuff -r 30 -c:a flac $filename
