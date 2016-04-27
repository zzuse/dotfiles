
##
# Your previous /Users/zz/.bash_profile file was backed up as /Users/zz/.bash_profile.macports-saved_2015-03-20_at_14:52:05
##

# MacPorts Installer addition on 2015-03-20_at_14:52:05: adding an appropriate PATH variable for use with MacPorts.
export PATH="/opt/local/bin:/opt/local/sbin:/Users/zz/Documents/self/bin/:/Users/zz/Documents/work/bin/:$PATH"
# Finished adapting your PATH environment variable for use with MacPorts.
export DYLD_LIBRARY_PATH="/Users/zz/Downloads/instantclient_11_2;/usr/local/"
export NLS_LANG="AMERICAN_AMERICA.ZHS16GBK"
export ORACLE_HOME="/Users/zz/Downloads/instantclient_11_2"
export CSCOPE_DB='/local/zhangzhen/cscope/$CSVIEW/cscope.out'
export CLICOLOR=1
export LSCOLORS='gxfxcxdxbxegedabagacad'
export GREP_OPTIONS="--color=auto"
export GREP_COLOR="30;45" 
export GOPATH=$HOME/Script/go
export GOROOT=/usr/local/go

export PATH="$GOPATH/bin:$GOROOT/bin:$PATH"

set -o vi
PS1='\[\e[1m\]\[\e[36;41m\]\u@\[\e[34;43m\]Work!\[\e[32;40m\]${PWD}>\[\e[0m\]'

alias cdw='cd /Users/zz/Documents/work'
alias cds='cd /Users/zz/Documents/self'
alias cdb='cd /Users/zz/Documents/work/bin'
alias cdd='cd /Users/zz/Downloads'
alias md5sum='md5 -r'
alias grep='grep -i $GREP_OPTIONS'
alias egrep='egrep $GREP_OPTIONS'
alias dus='du -d 2'
alias vi='mvim'

trap $HOME/.logout 0

#source /Users/zz/.iterm2_shell_integration.bash
