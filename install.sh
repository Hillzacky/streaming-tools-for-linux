#!/bin/bash

# Check if the user has root privileges
if [ "$EUID" -ne 0 ]; then
    echo "Please run the script as root or using sudo"
    exit 1
fi

# Detect the distribution
if [ -f /etc/os-release ]; then
    . /etc/os-release
    OS=$NAME
elif type lsb_release >/dev/null 2>&1; then
    OS=$(lsb_release -si)
else
    OS=$(uname -s)
fi

# Install FFmpeg and exiftools based on the distribution
case $OS in
    "Ubuntu")
        apt-get update
        apt-get install -y ffmpeg exiftool
        ;;
    "Debian")
        apt-get update
        apt-get install -y ffmpeg exiftool
        ;;
    "Fedora")
        dnf install -y ffmpeg exiftool
        ;;
    "CentOS Linux")
        yum install -y epel-release
        yum install -y ffmpeg exiftool
        ;;
    "Arch Linux")
        pacman -S ffmpeg exiftool
        ;;
    "OpenSUSE")
        zypper install ffmpeg exiftool
        ;;
    "Linux Mint")
        apt install ffmpeg exiftool
        ;;
    "Manjaro Linux")
        pacman -S ffmpeg exiftool
        ;;
    "Alpine Linux")
        apk add ffmpeg exiftool
        ;;
    *)
        echo "Unsupported distribution: $OS"
        exit 1
        ;;
esac

mkdir input
mkdir output
