alias pacman="sudo pacman"
alias nvim="/bin/nvim"
alias vim=nvim

alias yy="mpv --really-quiet --volume=50 --autofit=30% --geometry=-10-15 --ytdl --ytdl-format='mp4[height<=?720]' -ytdl-raw-options=playlist-start=1"

alias el="exa -l"

# Record terminal output to html
alias rec='rm -f /tmp/rec_output.txt && export LC_CTYPE="en_US.UTF-8" && asciinema rec --raw /tmp/rec_output.txt && cat /tmp/rec_output.txt | terminal-to-html | xclip -selection clipboard && echo "Screen recording copied to HTML"'
