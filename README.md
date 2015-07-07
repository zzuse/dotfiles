# dotfiles
===
git clone https://github.com/zzuse/dotfiles.git

Installation
------------
Install rcm on OSX:

    brew tap thoughtbot/formulae
    brew install rcm
    

Install rcm on Ubuntu:

    sudo add-apt-repository ppa:martin-frost/thoughtbot-rcm
    sudo apt-get update
    sudo apt-get install rcm
    
Setting the RCRC environment variable tells rcup to use standard configuration options.

Install the dotfiles for zsh:

    env RCRC=$HOME/dotfiles/rcrc rcup
    
Install the dotfiles for bash:

    export RCRC="$HOME/dotfiles/rcrc"
    rcup
    
You can safely run rcup multiple times to update:

    rcup
