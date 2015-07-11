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
    
Update dotfiles
------------

I can edit files in dotfiles directory, after that I just need to do:

    git add XXX
    git commit
    git push origin master

If I changed through web page, I will sync within terminal:

    git pull

Add dotfiles
------------

I have no idea, why mkrc command will add dotfiles to dotfiles-local by default
,so I run in ubuntu home dir like this:

    mkrc -d dotfiles .XXX
    
then it will symlink the .XXX to dotfiles dir as dotfiles/XXX


