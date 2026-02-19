# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH=$HOME/.oh-my-zsh
export SESSION_START_TIME=$(date +%s)

# Set name of the theme to load. Optionally, if you set this to "random"
# it'll load a random theme each time that oh-my-zsh is loaded.
# See https://github.com/robbyrussell/oh-my-zsh/wiki/Themes
#ZSH_THEME="robbyrussell"
#ZSH_THEME="random"
#ZSH_THEME="half-life"
ZSH_THEME="powerlevel10k/powerlevel10k"

source ~/dotfiles/func/notify-send
plugins=(git ruby vi-mode last-working-dir zsh-autosuggestions themes zsh-syntax-highlighting auto-notify)

if [ -f ~/.bash_profile ]; then
    source ~/.bash_profile
fi

source $ZSH/oh-my-zsh.sh

# User configuration
# set -o vi

local _current_dir="%{$fg_bold[blue]%}%~%{$reset_color%} "

alias grep='grep -i --color=auto --exclude-dir={.bzr,CVS,.git,.hg,.svn}'
#color cat
alias ccat='pygmentize -O style=borland -f console256 -g'

export PATH=$HOME/dotfiles-oschina/do:$HOME/opt/bin:$HOME/opt/sbin:$PATH

# find shorthand
function f () {
    find . -name "*$1*"
}

# message server
function ms () {
    nc -ul 2224
}

export AUTO_NOTIFY_THRESHOLD=30
export AUTO_NOTIFY_TITLE="Hey! %command has just finished"
export AUTO_NOTIFY_BODY="It completed in %elapsed seconds with exit code %exit_code"

# function rm(){  # 定义rm函数
#         timestamp=`date +%s`; # 定义时间戳垃圾袋
#         [ -d ~/rmbackup ] || mkdir -p ~/rmbackup; # 创建垃圾桶
#         mkdir ~/rmbackup/$timestamp; # 创建垃圾袋
#         /bin/mv -f $@ ~/rmbackup/$timestamp; #将垃圾移动到垃圾袋
# }
# export rm

if [ -f "${HOME}/.zshrc-`uname`" ]; then
    source "${HOME}/.zshrc-`uname`"
fi
#if [ -f "${HOME}/.zshrc-Brain" ]; then
#    source "${HOME}/.zshrc-Brain"
#fi
#if [ -f "${HOME}/.zshrc-VM" ]; then
#    source "${HOME}/.zshrc-VM"
#fi

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


test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"


export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion


. "$HOME/.local/bin/env"

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
