function recordSimulator() {
    echo "Video capture has started. Press Ctrl-C to stop capturing."
    local filename="$(date)"
    xcrun simctl io booted recordVideo --codec=h264 --mask=black --force "$filename.mov"
    echo "Finished capturing. Creating GIF..."
    ffmpeg -i "$filename.mov" -s 532x1080 -pix_fmt rgb24 -r 10 -f gif "$filename.gif" #| gifsicle --optimize=3 --delay=7 > "$filename.gif"
    echo "Done. Your GIF file is: $filename.gif"
}
