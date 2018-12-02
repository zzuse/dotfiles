# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load. Optionally, if you set this to "random"
# it'll load a random theme each time that oh-my-zsh is loaded.
# See https://github.com/robbyrussell/oh-my-zsh/wiki/Themes
#ZSH_THEME="robbyrussell"
ZSH_THEME="random"
#ZSH_THEME="base16"

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
plugins=(git ruby vi-mode last-working-dir zsh-autosuggestions themes)

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

export PATH=$PATH:$HOME/dotfiles-oschina/do:$HOME/opt/bin:$HOME/opt/sbin:$HOME/Library/Python/3.6/bin

# find shorthand
function f () {
    find . -name "*$1*"
}

# message server
function ms () {
    nc -ul 2224
}

function rm(){  # 定义rm函数
        timestamp=`date +%s`; # 定义时间戳垃圾袋
        [ -d ~/rmbackup ] || mkdir -p ~/rmbackup; # 创建垃圾桶
        mkdir ~/rmbackup/$timestamp; # 创建垃圾袋
        /bin/mv -f $@ ~/rmbackup/$timestamp; #将垃圾移动到垃圾袋
}
export rm

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

