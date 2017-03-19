#FOR echo
echo "   ________________ __ __   ______  ____  "
echo "   \___   /\___   /|  |  \ /  ___/_/ __ \ "
echo "    /    /  /    / |  |  / \___ \ \  ___/ "
echo "   /_____ \/_____ \|____/ /____  > \___  >"
echo "         \/      \/            \/      \/ "
echo "*!*!*!*!*!*!*!*!*!*!*!*!*!*!*!*!*!*!*!*!*!*!*!*"
echo "ctrl+\` macvim open finder selected"
echo "ctrl+shift+E send exit"

#FOR expect
export PATH="/opt/local/bin:/opt/local/sbin:/Users/zz/.do:$PATH"
#FOR instantclient_11_2
export DYLD_LIBRARY_PATH="/Users/zz/Documents/Software/instantclient_11_2;/usr/local/lib"
export NLS_LANG="AMERICAN_AMERICA.ZHS16GBK"
export ORACLE_HOME="/Users/zz/Documents/Software/instantclient_12_1"
#FOR dummy cscope
export CSCOPE_DB='/local/zhangzhen/cscope/$CSVIEW/cscope.out'
#FOR terminal
export CLICOLOR=1
export LSCOLORS='gxfxcxdxbxegedabagacad'
export GREP_OPTIONS="--color=auto"
export GREP_COLOR="30;45" 
#FOR Golang
export GOPATH=$HOME/Documents/Work/Self/Lang/GoLang
export GOROOT=/usr/local/go
export PATH="$GOPATH/bin:$GOROOT/bin:$PATH"
#FOR mvim
set -o vi
#FOR PS1
PS1='\[\e[1m\]\[\e[36;41m\]\u@\[\e[34;43m\]Working Smart!\[\e[32;40m\]${PWD}>\[\e[0m\]'
#FOR alias
alias cdw='cd /Users/zz/Documents/Work/Company/Lang'
alias cds='cd /Users/zz/Documents/Work/Self/Lang/'
alias md5sum='md5 -r'
alias grep='grep -i $GREP_OPTIONS'
alias egrep='egrep $GREP_OPTIONS'
alias dus='du -d 2'
alias vi='mvim'
alias vim='mvim'
alias ca='caffeinate'
alias lo='ls -la |lolcat -a -d 3'
alias b='bcomp'

trap $HOME/.logout 0

