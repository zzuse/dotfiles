alias cdb='cd /home/zz/Work/bin'
set -o vi
function title {
    if [ -z $1 ];then
    	echo -en "\033]2;${PWD}\007"
    else 
    	echo -en "\033]2;$1\007"
    fi
}
export PATH=/home/zz/Work/bin:$PATH
export GOROOT=$HOME/go
export PATH=$PATH:$GOROOT/bin

