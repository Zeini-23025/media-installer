#!/bin/bash

echo "============================================="
echo "        UNIVERSAL MEDIA DOWNLOADER PRO       "
echo "============================================="
echo

LOG_FILE="$HOME/media_downloader.log"

# ---------- 1. Dependency Checker ----------
install_dependency() {
    if ! command -v $1 >/dev/null 2>&1; then
        echo "[+] Installing $1 ..."
        if [[ $1 == "yt-dlp" ]]; then
            sudo curl -L https://github.com/yt-dlp/yt-dlp/releases/latest/download/yt-dlp \
                -o /usr/local/bin/yt-dlp
            sudo chmod +x /usr/local/bin/yt-dlp
        else
            sudo apt install -y "$1"
        fi
    else
        echo "[✓] $1 OK"
    fi
}

echo "[*] Checking dependencies..."
install_dependency "yt-dlp"
install_dependency "ffmpeg"
echo "[*] All dependencies installed!"
echo

# ---------- 2. Ask for URL ----------
read -p "Enter the media URL: " MEDIA_URL

if [[ -z $MEDIA_URL ]]; then
    echo "❌ Error: URL cannot be empty."
    exit 1
fi

# URL validation
if ! [[ $MEDIA_URL =~ ^https?:// ]]; then
    echo "❌ Invalid URL format. Must start with http:// or https://"
    exit 1
fi

# ---------- 3. Auto-detect platform ----------
platform="Unknown"
case "$MEDIA_URL" in
    *youtube.com*|*youtu.be*) platform="YouTube" ;;
    *tiktok.com*) platform="TikTok" ;;
    *facebook.com*|*fb.watch*) platform="Facebook" ;;
    *instagram.com*) platform="Instagram" ;;
    *twitter.com*|*x.com*) platform="Twitter/X" ;;
    *reddit.com*) platform="Reddit" ;;
    *) platform="Generic (yt-dlp supported)" ;;
esac

echo "[*] Detected Platform: $platform"
echo

# ---------- 4. Output directory ----------
read -p "Enter output directory: " OUTPUT_DIR
mkdir -p "$OUTPUT_DIR"

# ---------- 5. Media Type ----------
echo "Choose media type:"
echo "1) Video"
echo "2) Audio Only (mp3)"
read -p "Choose (1-2): " MEDIA_TYPE

if [[ $MEDIA_TYPE == 1 ]]; then

    echo
    echo "Choose video quality:"
    echo "1) 1080p"
    echo "2) 720p"
    echo "3) 480p"
    echo "4) Best Available"
    read -p "Enter choice (1-4): " QUALITY_CHOICE

    case $QUALITY_CHOICE in
        1) FORMAT="bestvideo[height<=1080]+bestaudio/best" ;;
        2) FORMAT="bestvideo[height<=720]+bestaudio/best" ;;
        3) FORMAT="bestvideo[height<=480]+bestaudio/best" ;;
        4) FORMAT="best" ;;
        *) echo "❌ Invalid option."; exit 1 ;;
    esac

elif [[ $MEDIA_TYPE == 2 ]]; then
    FORMAT="bestaudio"
else
    echo "❌ Invalid choice."
    exit 1
fi

# ---------- 6. Start Download ----------
echo
echo "============================================="
echo "Starting download..."
echo "Saving to: $OUTPUT_DIR"
echo "Format: $FORMAT"
echo "Log file: $LOG_FILE"
echo "============================================="
echo

yt-dlp \
  -f "$FORMAT" \
  --progress \
  --no-abort-on-error \
  --console-title \
  --embed-metadata \
  --embed-thumbnail \
  --write-sub --sub-lang "en,fr,ar" \
  --merge-output-format mp4 \
  --restrict-filenames \
  --retry-sleep 3 \
  --retries 10 \
  --fragment-retries 10 \
  --continue \
  -o "$OUTPUT_DIR/%(uploader)s - %(title)s.%(ext)s" \
  "$MEDIA_URL" 2>&1 | tee -a "$LOG_FILE"

echo
echo "============================================="
echo "         ✔ DOWNLOAD COMPLETED ✔             "
echo "============================================="
