#!/bin/bash

# Check if the user has root privileges
if [ "$EUID" -ne 0 ]; then
    echo "Please run the script as root or using sudo"
    exit 1
fi

# Loop through all the video files in the input directory
for file in output/*.mp4; do
    # Stream the video file to YouTube Live
    ffmpeg -re -i "$file" -c:v libx264 -preset veryfast -maxrate 1500k -bufsize 3000k -pix_fmt yuv420p -g 30 -c:a aac -b:a 60k -ar 44100 -f flv "rtmp://a.rtmp.youtube.com/live2/STREAM_KEY"
done
