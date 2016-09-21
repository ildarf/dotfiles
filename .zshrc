# Set Prompt
autoload -U colors && colors

autoload -Uz vcs_info

PROMPT="%{$fg[yellow]%}%B%n@%m %~ %#>%b %{$reset_color%}"
RPROMPT="%{$fg[yellow]%}%B%* %{$reset_color%}%(?.%{$fg[green]%}✔.%{$fg[red]%}✘)%b%{$reset_color%}"

# set keyboard repeat delay and rate
xset r rate 200 70

# set pointer acceleration
xset m 61 3

# set keyboardlayout changing shortcut
setxkbmap -layout gb,de,ru -variant ,,phonetic -option grp:ctrls_toggle

# man page coloration
man() {
      env \
	  LESS_TERMCAP_mb=$(printf "\e[1;34m") \
	  LESS_TERMCAP_md=$(printf "\e[1;34m") \
	  LESS_TERMCAP_me=$(printf "\e[0m") \
	  LESS_TERMCAP_se=$(printf "\e[0m") \
	  LESS_TERMCAP_so=$(printf "\e[1;42;33m") \
	  LESS_TERMCAP_ue=$(printf "\e[0m") \
	  LESS_TERMCAP_us=$(printf "\e[1;32m") \
	  man "$@"
}

# keybindings
# Make sure that the terminal is in application mode when zle is active, since
# only then values from $terminfo are valid
if (( ${+terminfo[smkx]} )) && (( ${+terminfo[rmkx]} )); then
  function zle-line-init() {
    echoti smkx
  }
  function zle-line-finish() {
    echoti rmkx
  }
  zle -N zle-line-init
  zle -N zle-line-finish
fi

ranger-cd() {
  tempfile=$(mktemp)
  ranger --choosedir="$tempfile" "${@:-$(pwd)}" < $TTY
  test -f "$tempfile" &&
  if [ "$(cat -- "$tempfile")" != "$(echo -n `pwd`)" ]; then
    cd -- "$(cat "$tempfile")"
  fi
  rm -f -- "$tempfile"
  xdotool key "ctrl+j"
}
# This binds Ctrl-O to ranger-cd:
zle -N ranger-cd
bindkey '\er' ranger-cd

bindkey '\ew' kill-region                             # [Esc-w] - Kill from the cursor to the mark
bindkey -s '\eu' 'pacaur -Suy\n'
bindkey -s '\ei' 'sudo pacman -S '
bindkey -s '\e9' 'uniblatt\n'
bindkey -s '\ex' ' | xsel -b\n'

# directories & uni-keybindings
bindkey -s '\e.' 'cd ..\n'
bindkey -s '\e-' 'cd -\n'
bindkey -s '\e0' '~/Downloads/'

bindkey '^r' history-incremental-search-backward      # [Ctrl-r] - Search backward incrementally for a specified string. The string may begin with ^ to anchor the search to the beginning of the line.
if [[ "${terminfo[kpp]}" != "" ]]; then
  bindkey "${terminfo[kpp]}" up-line-or-history       # [PageUp] - Up a line of history
fi
if [[ "${terminfo[knp]}" != "" ]]; then
  bindkey "${terminfo[knp]}" down-line-or-history     # [PageDown] - Down a line of history
fi

bindkey '^[k' up-line-or-search
bindkey '^[j' down-line-or-search

if [[ "${terminfo[kcuu1]}" != "" ]]; then
  bindkey "${terminfo[kcuu1]}" up-line-or-search      # start typing + [Up-Arrow] - fuzzy find history forward
fi
if [[ "${terminfo[kcud1]}" != "" ]]; then
  bindkey "${terminfo[kcud1]}" down-line-or-search    # start typing + [Down-Arrow] - fuzzy find history backward
fi

if [[ "${terminfo[khome]}" != "" ]]; then
  bindkey "${terminfo[khome]}" beginning-of-line      # [Home] - Go to beginning of line
fi
if [[ "${terminfo[kend]}" != "" ]]; then
  bindkey "${terminfo[kend]}"  end-of-line            # [End] - Go to end of line
fi

bindkey ' ' magic-space                               # [Space] - do history expansion

bindkey '^[[1;5C' forward-word                        # [Ctrl-RightArrow] - move forward one word
bindkey '^[[1;5D' backward-word                       # [Ctrl-LeftArrow] - move backward one word

if [[ "${terminfo[kcbt]}" != "" ]]; then
  bindkey "${terminfo[kcbt]}" reverse-menu-complete   # [Shift-Tab] - move through the completion menu backwards
fi

bindkey '^?' backward-delete-char                     # [Backspace] - delete backward
if [[ "${terminfo[kdch1]}" != "" ]]; then
  bindkey "${terminfo[kdch1]}" delete-char            # [Delete] - delete forward
else
  bindkey "^[[3~" delete-char
  bindkey "^[3;5~" delete-char
  bindkey "\e[3~" delete-char
fi

# Edit the current command line in $EDITOR
autoload -U edit-command-line
zle -N edit-command-line
bindkey '\C-x\C-e' edit-command-line

# end keybindings

# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000
setopt autocd
setopt extendedglob
bindkey -v
# End of lines configured by zsh-newuser-install

# The following lines were added by compinstall
zstyle :compinstall filename '/home/ildar/.zshrc'
autoload -Uz compinit
compinit
# End of lines added by compinstall

export KEYTIMEOUT=1

# Set $PATH variable
export PATH=$PATH:~/scripts

# Set GRAPHVIZ_DOT variable
export GRAPHVIZ_DOT=/usr/bin/dot

# Set $EDITOR 
export EDITOR=vim

# Set $BROWSER
export BROWSER="chromium"

# If not running interactively, do not do anything
[[ $- != *i* ]] && return
# [[ -z "$TMUX" ]] && exec tmux new-session \; curl -4 http://wttr.in/Dusseldorf \;
[[ -z "$TMUX" ]] && exec tmux

# pacman aliases
alias pacclean="sudo pacman -Rns $(pacman -Qqtd)"
alias upg='sudo pacman -Suy && yaourt -Suy --aur'

# Coloring aliases
alias ls="ls --color=always"
alias lsn="ls --color=never"
alias less="less -R"

# Bluetooth aliases
alias enbl="echo enable bluetooth | sudo tee /proc/acpi/ibm/bluetooth"
alias disbl="echo disable bluetooth | sudo tee /proc/acpi/ibm/bluetooth"

# uni-aliase

# typetrainer aliase
alias vttr='vim /home/ildar/typing/typetext1'
alias ttr='ttype2 "012334456677890.,-=+-=+/|\[]{}<>\*&&*()'"'"';:#%~_?" /home/ildar/typing/typetext1 | sed '"'"'s/4/^/g'"'"' | xsel -b'
alias vivttr='vim /home/ildar/typing/vimchars'
alias vittr='ttype2 "0123456789" /home/ildar/typing/vimchars | xsel -b'

# mounting aliase
alias stick="sudo mount -o umask=000 /dev/sdb1 ~/mnt && ranger ~/mnt"
alias platte="sudo mount -o gid=users, fmask=113, dmask=002 /dev/sdb1 ~/mnt && ranger ~/mnt"
mmnt() {
	sudo mount -o umask=000 $1 ~/mnt
	ranger ~/mnt
}

# video2brain aliases
alias v2bjava="cd /home/ildar/projekte/javagespaste && echo 'start v2b?' && yn && d vlc ~/v2b/java/*"
alias v2bfoto="cd /home/ildar/v2b/menschen_fotografieren && d vlc /home/ildar/v2b/menschen_fotografieren/*"

# aliases for scripts
alias pagenr="java /home/ildar/skripte/Zahlen"
alias photoshop="d wine /home/ildar/wine/Photoshop\ Portable/Photoshop.exe"
alias oct="cd /home/ildar/uni/octave && d octave --force-gui"
alias ren="renamescript &> /dev/null"
alias irm="invertedrm"

# aliases for shutdown, logout, suspend, etc
alias cls='cl && shutdown +0'
alias susp='systemctl suspend'

# directory aliases
alias dls='cd /home/fatkullin/Downloads/ && ranger-cd'

# function to create directory and immediately enter it
mkdirenter() {
	mkdir $1 && cd $1
}
alias mkd=mkdirenter

# screen settings configuration aliases
alias scr.dock="xrandr --output VGA1 --auto --right-of HDMI1"
alias scr.big="xrandr --output HDMI1 --auto --output VGA1 --off"
alias scr.small="xrandr --output VGA1 --auto --output HDMI1 --off"

# screensaver alias
alias soff="xset s off; xset -dpms"
alias son="xset s on; xset +dpms"

# program-aliases
alias mt='matlab&'
alias yd='youtube-dl'
alias gimptut='d vlc /mnt/win7/Users/ildar/Downloads/gimp_tutorial/*'
alias rns='renamescript'
alias bkg='background'

resizepics() {
	mogrify -resize 500x\> -verbose $* && mogrify -resize x750\> -verbose $*
}
alias res='resizepics'

# swap caps lock and esc in X
setxkbmap -option caps:swapescape

if [ -f ~/.workrc ]
then
	source ~/.workrc
fi

if [ -f ~/.alias/alias.print ]
then
	source ~/.alias/alias.print
fi

# load alias.notes file
if [ -f ~/.alias/alias.notes ]
then
	source ~/.alias/alias.notes
fi

# load alias.conf file
if [ -f ~/.alias/alias.conf ]
then
	source ~/.alias/alias.conf
fi

# load alias.uni file
if [ -f ~/.alias/alias.uni ]
then
	source ~/.alias/alias.uni
fi

# load alias.browser file
if [ -f ~/.alias/alias.browser ]
then
	source ~/.alias/alias.browser
fi

# load alias.java file
if [ -f ~/.alias/alias.j ]
then
	source ~/.alias/alias.j
fi

# load alias.cmd file
if [ -f ~/.alias/alias.cmd ]
then
	source ~/.alias/alias.cmd
fi

# load alias.utar file
if [ -f ~/.alias/alias.utar ]
then
	source ~/.alias/alias.utar
fi

# load alias.ydl file
if [ -f ~/.alias/alias.ydl ]
then
	source ~/.alias/alias.ydl
fi

# load alias.mnt file
if [ -f ~/.alias/alias.mnt ]
then
	source ~/.alias/alias.mnt
fi

# load alias.work file
if [ -f ~/.alias/alias.work ]
then
	source ~/.alias/alias.work
fi

# load alias.bahn file
if [ -f ~/.alias/alias.bahn ]
then
	source ~/.alias/alias.bahn
fi

# load alias.git file
if [ -f ~/.alias/alias.git ]
then
	source ~/.alias/alias.git
fi

