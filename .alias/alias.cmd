#!/bin/bash
# cmd-aliases


alias alias.cmd='vim ~/.alias/alias.cmd && source ~/.alias/alias.cmd'

newcmd() {
	echo "alias $1=\"$2\"" >> ~/.alias/alias.cmd
		source ~/.alias/alias.cmd
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

alias sd.music="cd ~/mnt/sdcard/music && ranger-cd"

hdr() {
	$BROWSER "https://www.youtube.com/watch?v=mGas0vqaoF8&feature=youtu.be&t=$1h$2m$3s"
}

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
	ranger-cd ~/pics/scans
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
 tmux send-keys "connect 90:7F:61:11:2B:FB" Enter
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

alias tibs="$BROWSER 'https://www.youtube.com/watch?v=Q5dU6serXkg'"
alias hypnose1="$BROWSER 'https://www.youtube.com/watch?v=K6wGvCh4i24'"
alias hypnose2="$BROWSER 'https://www.youtube.com/watch?v=-GrISxPLMzk'"

fixkeymap()
{
	sudo cp -v /usr/share/X11/xkb/symbols/gb{,.bak}
	sudo cp -v ~/git/dotfiles/gb /usr/share/X11/xkb/symbols/gb
}

pdfs()
{
	pdfgrep -in "$*" *.pdf
}

ideavimrc()
{
	vim ~/.ideavimrc ~/.vimrc
}

band()
{
	ranger-cd ~/band
}

newalias()
{
	name=$1
	cat << EOF > ~/.alias/alias.$name
# /bin/bash
# $name-aliases

alias alias.$name='vim ~/.alias/alias.$name && source ~/.alias/alias.$name'

new$name() {
		echo "alias \$1=\"\$2\"" >> ~/.alias/alias.$name
				source ~/.alias/alias.$name
}
EOF

	echo file alias.$name created
	cat << EOF >> ~/.zshrc
# load alias.$name file
if [ -f ~/.alias/alias.$name ]
then
	source ~/.alias/alias.$name
fi

EOF
	echo create new alias in alias.$name file with:
	echo new$name alias-name string
	source ~/.zshrc
}

vw () {
	which_cmd=`which $1`
	if [ -f $which_cmd ]
	then
		vim $which_cmd
	else
		echo "file does not exist"
	fi
}

conf.push ()
{
	cd ~/git/dotfiles
	git add .
	git commit
	git push
	cd ~/git/scripts
	git add .
	git commit
	git push
	cd ~
}

conf.pull ()
{
	cd ~/git/dotfiles
	git pull
	cd ~/git/scripts
	git pull
	cd ~
}
