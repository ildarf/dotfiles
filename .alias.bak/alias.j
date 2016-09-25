# java-aliases

alias alias.j='vim ~/.alias/alias.j && source ~/.alias/alias.j'

newjava() {
	echo "alias $1=\"$2\"" >> ~/.alias/alias.j
	source ~/.alias/alias.j
}

newjav() {
	tmux select-pane -U
	tmux send-keys Escape
	tmux send-keys Escape
	tmux send-keys ":tabe $1.java" Enter
	tmux select-pane -D
	tmux send-keys "javac $1.java && java $1"
	tmux select-pane -U
	tmux send-keys "ipublic class $* {" Escape
	tmux send-keys "ddO"
}

javatest() {
	tmux split-window -v -p 30
	# tmux send-keys 'javac Test.java && java Test'
	# tmux select-pane -U
	vim Test.java
}
