#!/bin/bash

# Check if the user has root privileges
if [ "$EUID" -ne 0 ]; then
    echo "Please run the script as root or using sudo"
    exit 1
fi

# Set up the Facebook Live stream
facebook_stream() {
    # Replace STREAM_KEY with your Facebook Live stream key
    ffmpeg -re -i "$1" -c:v libx264 -preset veryfast -maxrate 2500k -bufsize 5000k -pix_fmt yuv420p -g 60 -c:a aac -b:a 128k -ar 44100 -f flv "rtmp://rtmp-api.facebook.com:80/rtmp/STREAM_KEY"
}

# Set up the YouTube Live stream
youtube_stream() {
    # Replace STREAM_KEY with your YouTube Live stream key
    ffmpeg -re -i "$1" -c:v libx264 -preset veryfast -maxrate 2500k -bufsize 5000k -pix_fmt yuv420p -g 60 -c:a aac -b:a 128k -ar 44100 -f flv "rtmp://a.rtmp.youtube.com/live2/STREAM_KEY"
}

# Set up the Zoom stream
zoom_stream() {
    # Replace STREAM_URL and STREAM_KEY with your Zoom stream URL and stream key
    ffmpeg -re -i "$1" -c:v libx264 -preset veryfast -maxrate 2500k -bufsize 5000k -pix_fmt yuv420p -g 60 -c:a aac -b:a 128k -ar 44100 -f flv "rtmp://live-api.zoom.us:80/webhook/stream?key=STREAM_KEY&url=STREAM_URL"
}

# Loop through all the video files in the output directory
while true; do
    for file in output/*.mp4; do
        # Stream the video file to Facebook Live
        facebook_stream "$file"

        # Stream the video file to YouTube Live
        youtube_stream "$file"

        # Stream the video file to Zoom
        zoom_stream "$file"
    done
done
