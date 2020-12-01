# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load. Optionally, if you set this to "random"
# it'll load a random theme each time that oh-my-zsh is loaded.
# See https://github.com/robbyrussell/oh-my-zsh/wiki/Themes
#ZSH_THEME="robbyrussell"
#ZSH_THEME="random"
ZSH_THEME="half-life"

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion. Case
# sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

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

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git ruby vi-mode last-working-dir zsh-autosuggestions themes zsh-syntax-highlighting)

if [ -f ~/.bash_profile ]; then
    source ~/.bash_profile
fi

source $ZSH/oh-my-zsh.sh

# User configuration
# set -o vi

local _current_dir="%{$fg_bold[blue]%}%~%{$reset_color%} "

alias grep='grep -i --color=auto --exclude-dir={.bzr,CVS,.git,.hg,.svn}'
#color cat
alias c='pygmentize -O style=borland -f console256 -g'

export PATH=$HOME/dotfiles-oschina/do:$HOME/opt/bin:$HOME/opt/sbin:$HOME/Library/Python/3.6/bin:$PATH

# find shorthand
function f () {
    find . -name "*$1*"
}

# message server
function ms () {
    nc -ul 2224
}

# function rm(){  # 定义rm函数
#         timestamp=`date +%s`; # 定义时间戳垃圾袋
#         [ -d ~/rmbackup ] || mkdir -p ~/rmbackup; # 创建垃圾桶
#         mkdir ~/rmbackup/$timestamp; # 创建垃圾袋
#         /bin/mv -f $@ ~/rmbackup/$timestamp; #将垃圾移动到垃圾袋
# }
# export rm

#OS specific
#case `uname` in
#  Darwin)
#    source "${HOME}/.zshrc-Darwin"
#  ;;
#  Linux)
#    source "${HOME}/.zshrc-Linux"
#  ;;
#  FreeBSD)
#    source "${HOME}/.zshrc-`uname`"
#  ;;
#esac
if [ -f "${HOME}/.zshrc-`uname`" ]; then
    source "${HOME}/.zshrc-`uname`"
fi
if [ -f "${HOME}/.zshrc-Brain" ]; then
    source "${HOME}/.zshrc-Brain"
fi
if [ -f "${HOME}/.zshrc-VM" ]; then
    source "${HOME}/.zshrc-VM"
fi

#FOR echo
if [ -t 1 ]; then
  RB_RED=$(printf '\033[38;5;196m')
  RB_ORANGE=$(printf '\033[38;5;202m')
  RB_YELLOW=$(printf '\033[38;5;226m')
  RB_GREEN=$(printf '\033[38;5;082m')
  RB_BLUE=$(printf '\033[38;5;021m')
  RB_INDIGO=$(printf '\033[38;5;093m')
  RB_VIOLET=$(printf '\033[38;5;163m')

  RED=$(printf '\033[31m')
  GREEN=$(printf '\033[32m')
  YELLOW=$(printf '\033[33m')
  BLUE=$(printf '\033[34m')
  BOLD=$(printf '\033[1m')
  RESET=$(printf '\033[m')
else
  RB_RED=""
  RB_ORANGE=""
  RB_YELLOW=""
  RB_GREEN=""
  RB_BLUE=""
  RB_INDIGO=""
  RB_VIOLET=""

  RED=""
  GREEN=""
  YELLOW=""
  BLUE=""
  BOLD=""
  RESET=""
fi

printf "%s   ________%s________%s __ __ %s  ______%s  ____  %s\n" $RB_RED $RB_ORANGE $RB_YELLOW $RB_GREEN $RB_BLUE $RB_RESET
printf "%s   \___   /%s\___   /%s|  |  \%s /  ___/%s_/ __ \ %s\n" $RB_RED $RB_ORANGE $RB_YELLOW $RB_GREEN $RB_BLUE $RB_RESET
printf "%s    /    / %s /    / %s|  |  /%s \___ \ %s\  ___/ %s\n" $RB_RED $RB_ORANGE $RB_YELLOW $RB_GREEN $RB_BLUE $RB_RESET
printf "%s   /_____ \%s/_____ \%s|____/ %s/____  >%s \___  >%s\n" $RB_RED $RB_ORANGE $RB_YELLOW $RB_GREEN $RB_BLUE $RB_RESET
printf "%s         \/%s      \/%s       %s     \/ %s     \/ %s\n" $RB_RED $RB_ORANGE $RB_YELLOW $RB_GREEN $RB_BLUE $RB_RESET
printf "%s*!*!*!*!*!*!*!*!*!*!*!*!*!*!*!*!*!*!*!*!*!*!*!*%s\n" $RB_VIOLET ${BOLD} $RB_RESET
printf "%s%sctrl+shift+Q send exit in iTerm2%s\n" $RB_INDIGO ${BOLD} $RB_RESET
printf "%s%sctrl+shift+option+left send topleft in phoenix%s\n" $RB_INDIGO ${BOLD} $RB_RESET

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
# export SSH_KEY_PATH="~/.ssh/dsa_id"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

