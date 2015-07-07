# dotfiles
git clone https://github.com/zzuse/dotfiles.git

Install rcm on OSX:
brew tap thoughtbot/formulae
brew install rcm

Install rcm on Ubuntu:
sudo add-apt-repository ppa:martin-frost/thoughtbot-rcm
sudo apt-get update
sudo apt-get install rcm

under zsh
Install the dotfiles:
env RCRC=$HOME/dotfiles/rcrc rcup
Setting the RCRC environment variable tells rcup to use standard configuration options:

You can safely run rcup multiple times to update:

rcup
