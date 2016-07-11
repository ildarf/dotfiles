# /bin/bash
# cmd-aliases


alias alias.cmd='vim /home/ildar/.alias/alias.cmd && source /home/ildar/.alias/alias.cmd'

newcmd() {
	echo "alias $1=\"$2\"" >> ~/.alias/alias.cmd
		source /home/ildar/.alias/alias.cmd
}

newf() {
	tmux select-pane -U
	tmux send-keys Escape
	tmux send-keys Escape
	tmux send-keys ":tabe $1" Enter
	tmux select-pane -D
	tmux send-keys "$1"
	tmux select-pane -U
	tmux send-keys "i" Escape
}

cide() {
	tmux split-window -v -p 30
		vim -p $*
}
alias sbox.c="cd ~/projekte/c/sbox"
alias sbox.java="cd ~/projekte/java/sbox"
alias sbox.bash="cd ~/projekte/bash/sbox"

alias sd.music="cd /home/ildar/mnt/sdcard/music && ranger-cd"

hdr() {
	chromium "https://www.youtube.com/watch?v=mGas0vqaoF8&feature=youtu.be&t=$1h$2m$3s"
}

# lcthw() {
#  	tmux break-pane
#  	tmux rename-window "lcthw"
#  	cd /home/ildar/lcthw
#  	tmux split-window -h -c /home/ildar/lcthw
#  	tmux split-window -c /home/ildar/lcthw -t 0 -p 20
#  	tmux split-window -c /home/ildar/lcthw -t 1
#   	tmux send-keys -t 1 "clear" Enter
#   	tmux send-keys -t 1 "ls ${!#} | entr -c make ${!#%.*}" Enter
#   	tmux send-keys -t 2 "clear" Enter
#   	tmux send-keys -t 2 "echo ${!#%.*} | entr -c ./${!#%.*}" Enter
#  	tmux send-keys -t 3 "clear" Enter
#  	tmux send-keys -t 3 "echo ${!#%.*} | entr -c valgrind --leak-check=full ./${1%.*}" Enter
#  	tmux select-pane -t 0
#  	tmux send-keys "vim -p Makefile $*" Enter
#  	# tmux send-keys -t 0 ":tablast" Enter
#  	# vim -p Makefile $*
# }

alias offscreen="xrandr --output LVDS1 --off --output VGA1 --off --output HDMI1 --off"

valwatch() {
	echo ${1%.*} | entr -c valgrind ./${1%.*} ${@:2}
}

valwatch.lck() {
	echo ${1%.*} | entr -c valgrind --leak-check=full ./${1%.*} ${@:2}
}

makewatch() {
	echo $1 | entr -c make ${1%.*}
}

runwatch() {
	echo ${1%.*} | entr -c ./${1%.*}
}

entrwatch() {
	ls --color=never "${@:2}" | entr -c $1
}

geoip() {
	geoiplookup $*
		geoiplookup -f /usr/share/GeoIP/GeoLiteCity.dat $*
}

alias uziprm="uzipall +rm"

scans() {
	ranger-cd ~/Pictures/scans
}

scrs()
{
	ranger-cd ~/scripts
}

blon()
{
	tmux send-keys "bluetoothctl -a" Enter
		tmux send-keys "power on" Enter
		tmux send-keys "discoverable on" Enter
		tmux send-keys "scan on" Enter
# tmux send-keys "connect 90:7F:61:11:2B:FB" Enter
		tmux send-keys "exit" Enter
		xset s off
		xset -dpms
}

alias l="ls -lah"
alias l.="ls -d .* --color=always"
alias gr='grep --ignore-case --color=auto'
alias doc="d okular"
alias dok="d kate"
alias utar="tar xvfz"
alias crs="createscript"
alias crsw="createscriptwatch"
alias crj="createjava"
alias pdfgrep="pdfgrep -in"
alias srcz="source ~/.zshrc"
alias pactree="pactree -c"
alias v="d gwenview"
alias ips="ip addr show"
alias lnt="learntimer"

alias tibs="chromium 'https://www.youtube.com/watch?v=Q5dU6serXkg'"
alias hypnose1="chromium 'https://www.youtube.com/watch?v=K6wGvCh4i24'"
alias hypnose2="chromium 'https://www.youtube.com/watch?v=-GrISxPLMzk'"

fixkeymap()
{
	sudo cp -v /usr/share/X11/xkb/symbols/gb{,.bak}
	sudo cp -v /home/ildar/gb /usr/share/X11/xkb/symbols/gb
}

pdfs()
{
	pdfgrep -in "$*" *.pdf
}

alias upgrade.shrottkiste="ssh root@134.99.154.31 pacman -Suy"

wintuxguitar()
{
	wine /mnt/win7/Program\ Files\ \(x86\)/tuxguitar-1.3.2/tuxguitar.exe
}

ideavimrc()
{
	vim -p ~/.ideavimrc ~/.vimrc
}

band()
{
	ranger-cd ~/band
}

newalias()
{
	name=$1
	cat << EOF > alias.$name
# /bin/bash
# $name-aliases

alias alias.$name='vim /home/ildar/.alias/alias.$name && source /home/ildar/.alias/alias.$name'

new$name() {
		echo "alias \$1=\"\$2\"" >> ~/.alias/alias.$name
				source /home/ildar/.alias/alias.$name
}
EOF

	echo file alias.$name created
	cat << EOF >> /home/ildar/.zshrc
# load alias.$name file
if [ -f ~/.alias/alias.$name ]
then
	source ~/.alias/alias.$name
fi

EOF
	echo create new alias in alias.$name file with:
	echo new$name alias-name string
	source /home/ildar/.zshrc
}
