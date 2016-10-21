# dotfiles
===
inspired by https://github.com/thoughtbot/dotfiles  
git clone https://github.com/zzuse/dotfiles.git  
brew install mackup https://github.com/lra/mackup

Installation
------------
Install rcm on OSX:

    brew tap thoughtbot/formulae
    brew install rcm
    

Install rcm on Ubuntu:

    sudo add-apt-repository ppa:martin-frost/thoughtbot-rcm
    sudo apt-get update
    sudo apt-get install rcm
    
Install to an old linux machine from source,my machine have many openssl problem, so:

    wget http://curl.haxx.se/ca/cacert.pem
    curl --cacert cacert.pem  -LO https://thoughtbot.github.io/rcm/dist/rcm-1.2.3.tar.gz
    tar -xvf rcm-1.2.3.tar.gz && \
    cd rcm-1.2.3 && \
    ./configure && \
    make && \
    make install
    
For more about rcm install, plz consult https://github.com/thoughtbot/rcm
    
Setup
------------
Setting the RCRC environment variable tells rcup to use standard configuration options.

Install the dotfiles for zsh:

    env RCRC=$HOME/dotfiles/rcrc rcup
    
Install the dotfiles for bash:

    export RCRC="$HOME/dotfiles/rcrc"
    rcup
    
You can safely run rcup multiple times to update:

    rcup

some sensitive data will add to private git-locations, so export RCRC other values to adapt to private git-locations
    
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

in my configuration, mkrc command will add dotfiles to dotfiles-local by default, if U want to add to a dotfiles dir, U will run like this:

    mkrc -d dotfiles .XXX
    
then it will symlink the .XXX to dotfiles dir as dotfiles/XXX

Back up OSX APP plist or other files to iCloud 
------------

some none dotfiles will use mackup to backup  
after install mackup then to add mackup supported apps:

    vi ~/.mackup.cfg
    [storage]
    engine = icloud
    [applications_to_sync]
    ssh

if an app is not officialy supported by mackup:

    $ cat ~/.mackup/nethack.cfg
    [application]
     name = Nethack
    [configuration_files]
     .nethackrc

some command:

    # Install Mackup
    brew install mackup
    # Launch it and back up your files
    mackup backup
    # Launch it and restore your files
    mackup restore
    #Copy back any synced config file to its original place.
    mackup uninstall
    #Display the list of applications supported by Mackup.
    mackup list
    #help
    mackup -h

Only for me
------------

this part include multi-platform configure:

* this can be more smart if adding system detecting code.
* bashrc and bash_aliases is for Ubuntu
* bash_privacy is for REHL5
* bash_profile is for Mac

TODO
----------

add some bootstrap or brew.sh
