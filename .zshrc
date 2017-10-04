# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

setxkbmap -layout gb,de,ru -variant ,,phonetic -option grp:ctrls_toggle
xset r rate 200 70
xset m 120 3
setxkbmap -option caps:swapescape

# Path to your oh-my-zsh installation.
ZSH=/usr/share/oh-my-zsh/

# Set name of the theme to load. Optionally, if you set this to "random"
# it'll load a random theme each time that oh-my-zsh is loaded.
# See https://github.com/robbyrussell/oh-my-zsh/wiki/Themes
#ZSH_THEME="af-magic"

# af-magic.zsh-theme
# Repo: https://github.com/andyfleming/oh-my-zsh
# Direct Link: https://github.com/andyfleming/oh-my-zsh/blob/master/themes/af-magic.zsh-theme

if [ $UID -eq 0 ]; then NCOLOR="red"; else NCOLOR="green"; fi
local return_code="%(?..%{$fg[red]%}%? ↵%{$reset_color%})"

# primary prompt
PROMPT='$FG[237]------------------------------------------------------------%{$reset_color%}
$FG[032]%~\
$(git_prompt_info) \
$FG[105]%(!.#.»)%{$reset_color%} '
PROMPT2='%{$fg[red]%}\ %{$reset_color%}'
RPS1='${return_code}'


# color vars
eval my_gray='$FG[237]'
eval my_orange='$FG[214]'

# right prompt
if type "virtualenv_prompt_info" > /dev/null
then
	RPROMPT='$(virtualenv_prompt_info)$my_gray%n@%m%{$reset_color%}%'
else
	RPROMPT='$my_gray%n@%m%{$reset_color%}%'
fi

# git settings
ZSH_THEME_GIT_PROMPT_PREFIX="$FG[075]($FG[078]"
ZSH_THEME_GIT_PROMPT_CLEAN=""
ZSH_THEME_GIT_PROMPT_DIRTY="$my_orange*%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_SUFFIX="$FG[075])%{$reset_color%}"
# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion. Case
# sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# The optional three formats: "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder
#

# Set Prompt
autoload -U colors && colors
autoload -Uz vcs_info
autoload -U edit-command-line
autoload -Uz compinit && compinit
zstyle :compinstall filename '/home/ildar/.zshrc'

PROMPT="%{$fg[green]%}%B%n@%m %~ %#>%b %{$reset_color%}"
RPROMPT="%{$fg[green]%}%B%* %{$reset_color%}%(?.%{$fg[green]%}✔.%{$fg[red]%}✘)%b%{$reset_color%}"

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

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git, gradle) 

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# ssh
# export SSH_KEY_PATH="~/.ssh/rsa_id"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

ZSH_CACHE_DIR=$HOME/.cache/oh-my-zsh
if [[ ! -d $ZSH_CACHE_DIR ]]; then
  mkdir $ZSH_CACHE_DIR
fi

# source $ZSH/oh-my-zsh.sh

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
zle -N ranger-cd
bindkey '\er' ranger-cd


zle -N edit-command-line
bindkey '^r' history-incremental-search-backward
bindkey '^[k' up-line-or-search
bindkey '^[j' down-line-or-search

if [[ "${terminfo[kcuu1]}" != "" ]]; then
  bindkey "${terminfo[kcuu1]}" up-line-or-search      # start typing + [Up-Arrow] - fuzzy find history forward
fi
if [[ "${terminfo[kcud1]}" != "" ]]; then
  bindkey "${terminfo[kcud1]}" down-line-or-search    # start typing + [Down-Arrow] - fuzzy find history backward
fi
bindkey -v

HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000

setopt autocd
setopt extendedglob

export KEYTIMEOUT=1
export PATH=$PATH:~/scripts:~/bin
export EDITOR=vim
export BROWSER="qutebrowser"

if [[ "${terminfo[kcbt]}" != "" ]]; then
  bindkey "${terminfo[kcbt]}" reverse-menu-complete   # [Shift-Tab] - move through the completion menu backwards
fi

# If not running interactively, do not do anything
[[ $- != *i* ]] && return
# [[ -z "$TMUX" ]] && exec tmux new-session \; curl -4 http://wttr.in/Dusseldorf \;
[[ -z "$TMUX" ]] && exec tmux


# ssh-agent
export SSH_AUTH_SOCK="$XDG_RUNTIME_DIR/ssh-agent.socket"
SSH_ENV=$HOME/.ssh/environment

start_agent()
{
    echo "initializing new SSH agent ..."
    ssh-agent | sed 's/^echo/#echo/' > $SSH_ENV
    echo "succeeded"
    chmod 600 $SSH_ENV
    . $SSH_ENV
    ssh-add
}

# source SSH settings, if applicable
if [[ -f $SSH_ENV ]]
then
    . $SSH_ENV # > /dev/null
    ps -ef | grep $SSH_AGENT_PID | grep ssh-agent > /dev/null || {
        curl -4 http://wttr.in/Düsseldorf 2> /dev/null; start_agent; source ~/.zshrc && conf.pull&; pacaur -Suy
    }
else
    start_agent
fi

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

