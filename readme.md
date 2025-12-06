# 🎥 Universal Media Downloader PRO  
A powerful, cross-platform Bash-based media downloader capable of downloading videos, audio, reels, shorts, and stories from **any social media platform**, including:

- YouTube  
- TikTok  
- Facebook  
- Instagram  
- Twitter / X  
- Reddit  
- Vimeo  
- And hundreds of other sites supported by yt-dlp  

This tool provides a simple terminal interface while offering advanced controls such as customizable quality, audio-only extraction, automatic installation of dependencies, subtitles download, safe filenames, and automatic resuming of downloads.

---

## ⚡ Features

### ✅ Multi-platform support
Download media from:
- YouTube (videos, playlists, channels)
- TikTok (single videos or full profiles)
- Facebook (videos & reels)
- Instagram (reels, posts, stories)
- Twitter / X videos
- Reddit videos
- Any platform supported by **yt-dlp**

### ✅ Smart Quality Control
Choose between:
- 1080p  
- 720p  
- 480p  
- Best available  
- Audio-only (MP3 or bestaudio)

### ✅ Automatic Dependency Installation
The script checks and installs:
- `yt-dlp`
- `ffmpeg`

### ✅ Enhanced Download Options
- Subtitles (Arabic/French/English when available)
- Thumbnails embedding
- Metadata embedding
- Safe filenames
- Automatic retries and resume
- Progress bars and console title updates
- Log file for debugging and history

### ✅ Auto-Platform Detection
The script identifies the platform from the URL and adjusts behavior accordingly.

---

## 🛠 Requirements

The script supports **Linux**, especially:

- Ubuntu
- Debian
- Pop!\_OS
- Linux Mint
- WSL (Windows Subsystem for Linux)

Required binaries (installed automatically if missing):

- `yt-dlp`
- `ffmpeg`
- `curl`
- `bash`

---

## 📦 Installation

1. Clone the repository:

```bash
git clone https://github.com/your-username/universal-media-downloader.git
cd universal-media-downloader
