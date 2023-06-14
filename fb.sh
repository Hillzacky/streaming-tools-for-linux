#!/bin/bash

# Check if the user has root privileges
if [ "$EUID" -ne 0 ]; then
    echo "Please run the script as root or using sudo"
    exit 1
fi

# Loop through all the video files in the input directory
for file in output/*.mp4; do
    # Stream the video file to Facebook Live
    ffmpeg -re -i "$file" -c:v libx264 -preset veryfast -maxrate 2500k -bufsize 5000k -pix_fmt yuv420p -g 60 -c:a aac -b:a 128k -ar 44100 -f flv "rtmp://rtmp-api.facebook.com:80/rtmp/STREAM_KEY"
done
