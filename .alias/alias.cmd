#!/bin/bash
# cmd-aliases


alias alias.cmd='vim ~/.alias/alias.cmd && source ~/.alias/alias.cmd'

newcmd() {
	echo "alias $1=\"$2\"" >> ~/.alias/alias.cmd
		source ~/.alias/alias.cmd
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
alias utar="tar xvfz"
alias crs="createscript"
alias crsw="createscriptwatch"
alias crj="createjava"
alias pdfgrep="pdfgrep -in"
alias srcz="source ~/.zshrc"
alias pactree="pactree -c"
alias lnt="learntimer"
alias vim="vim -p"
alias grep="grep --color"
alias tibs="$BROWSER 'https://www.youtube.com/watch?v=Q5dU6serXkg'"
alias hypnose1="$BROWSER 'https://www.youtube.com/watch?v=K6wGvCh4i24'"
alias hypnose2="$BROWSER 'https://www.youtube.com/watch?v=-GrISxPLMzk'"

fixkeymap()
{
	sudo cp -v /usr/share/X11/xkb/symbols/gb{,.bak}
	sudo cp -v ~/git/dotfiles/gb /usr/share/X11/xkb/symbols/gb
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
