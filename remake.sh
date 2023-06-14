#!/bin/bash

# Check if the user has root privileges
if [ "$EUID" -ne 0 ]; then
    echo "Please run the script as root or using sudo"
    exit 1
fi

# Loop through all the video files in the current directory
for file in *.mp4 *.avi *.mkv; do
    # Clean up metadata
    exiftool -all= "$file"
    exiftool -Comment="$(date +%s%N | sha256sum | head -c 32)" "$file"
    # Compress the size
    ffmpeg -i "$file" -c:v libx264 -crf $((RANDOM%23+30)) -c:a aac -b:a $((RANDOM%96+128))k -movflags +faststart "temp.mp4"
    
    # Change the MD5
    md5sum "temp.mp4" > "${file}.md5"
    
    # Make it unique
    mv "temp.mp4" "$(date +%s%N | sha256sum | head -c 32).mp4"
done
