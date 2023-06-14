ffmpeg -re -stream_loop -1 -i "./input/*.mp4" -c copy -f flv rtmp://your-stream-url
