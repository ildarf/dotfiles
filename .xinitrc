xrdb -merge ~/.Xresources

# cat	~/git/i3/config.base \
# ~/git/i3/config.local > ~/.config/i3/config

# set keyboard repeat delay and rate
xset r rate 200 70

# set pointer acceleration
xset m 100 3

# disable screensaver
xset s off
xset -dpms
xset b off

# swap caps lock and esc in X
setxkbmap -option caps:swapescape

# set keyboardlayout changing shortcut
setxkbmap -layout gb,de,ru -variant ,,phonetic -option grp:ctrls_toggle

exec i3
