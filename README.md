# dotfiles
-----------
# REF
*   inspired by https://github.com/thoughtbot/dotfiles  
*   ~(deprecated) brew install mackup https://github.com/lra/mackup, now more used in Linux. on Mac, you need install software by your own needs~  

# HOW TO COOK
*   git clone https://github.com/zzuse/dotfiles.git
*   Install, `brew install rcm` or `sudo port install rcm`
*   Run `export RCRC="$HOME/dotfiles/rcrc";rcup`, all is set!  
    It will first link all configurations from dotfiles to home dot dir  
Then automaticlly run hooks/post-up, which is a bunch of installation post scripts. 

Installation
------------
## For run `rcup`, you need `rcm` package first:

### Preinstall on a fresh clean OSX system:

    RCM is a dotfiles management system. 
    This automation script is to install on an fresh clean OSX. 
    First you need install Xcode and brew.   
    Then you will install as follow steps.  
    
### Install rcm on OSX:

Deprecated: ~brew tap thoughtbot/formulae~  
Just: brew install rcm
    

### Install rcm on Ubuntu:

*   in case using python3.6 on ubuntu 16.04, you need:
    	`/usr/lib/python3/dist-packages# ln -s apt_pkg.cpython-35m-x86_64-linux-gnu.so apt_pkg.cpython-36m-x86_64-linux-gnu.so`
*   normally:
```sh
    sudo add-apt-repository ppa:martin-frost/thoughtbot-rcm
    sudo apt-get update
    sudo apt-get install rcm
```
    
### Install rcm on Centos:

    cd /etc/yum.repos.d/
    wget https://download.opensuse.org/repositories/utilities/RHEL_7/utilities.repo
    yum install rcm


### From source, Like an an old linux machine, my old machine have many openssl problem, so:

    wget http://curl.haxx.se/ca/cacert.pem
    curl --cacert cacert.pem  -LO https://thoughtbot.github.io/rcm/dist/rcm-1.2.3.tar.gz
    tar -xvf rcm-1.2.3.tar.gz && \
    cd rcm-1.2.3 && \
    ./configure && \
    make && \
    make install
    
## For more about rcm install, please see https://github.com/thoughtbot/rcm. 
    
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
    
Maintaining dotfiles
------------

I can edit files in dotfiles directory, after that I just need to do:

    git add XXX
    git commit
    git push origin master

If I changed through web page, I will sync within terminal:

    git pull

Add dotfiles
------------

in my configuration, mkrc command will add dotfiles to dotfiles-local by default, if U want to add to the dotfiles dir, U will run like this:

    mkrc -d dotfiles .XXX
    
then it will symlink the .XXX to dotfiles dir as dotfiles/XXX

Back up OSX APP plist or other files to iCloud (not use anymore, deprecated)
------------

some none dotfiles will use mackup to backup  
after install mackup then to add mackup supported apps:

    vi ~/.mackup.cfg
    [storage]
    engine = icloud
    [applications_to_sync]
    terminal

(deprecated)if an app is not officialy supported by mackup:

    $ cat ~/.mackup/nethack.cfg
    [application]
     name = Nethack
    [configuration_files]
     .nethackrc

(deprecated)some command:

    # Install Mackup
    brew install mackup
    #Copy back any synced config file to its original place.
    mackup uninstall
    #Display the list of applications supported by Mackup.
    mackup list
    #help
    mackup -h

(deprecated)you may use follow commands more often:

    # Launch it and back up your files
    mackup backup
    # Launch it and restore your files
    mackup restore

Backup Apps On OSX
------------

    brew bundle dump

LICENSE
----------
MIT
