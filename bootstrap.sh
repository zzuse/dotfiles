#!/bin/sh
# Check for Homebrew,
# Install if we don't have it
if test ! $(which brew); then
	  echo "Installing homebrew..."
	    ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
fi

chsh -s $(which zsh)
# Update homebrew recipes
echo "updating brew..."
brew update

#taps

taps=(
	thoughtbot/formulae
)
echo "installing binaries..."
brew tap ${taps[@]}

brew cleanup

binaries=(
	cntlm
	htop
	rcm
	mackup
	"macvim --with-cscope --with-lua --with-override-system-vim"
	"wget --with-iri"
	tree
	socat
	node
	nmap
	e2fsprogs
	neofetch
	"reattach-to-user-namespace --with-wrap-pbcopy-and-pbpaste"
	zsh
	zsh-completions
	tmux
)

echo "installing binaries..."
brew install ${binaries[@]}

brew cleanup

brew install caskroom/cask/brew-cask

# Apps
apps=(
    appcleaner
    atom
    dropbox
    evernote
    google-chrome
    google-drive
    gpgtools
    qq
    qqmusic
    neteasemusic
    skitch
    vlc
    mplayerx
    keycastr
    beyond-compare
    aliwangwang
    calibre
    coderunner
    filezilla
    flux
    geektool
    gitup
    hex-fiend
    keepassx
#    nutstore
    shadowsocksx
    staruml
#    torbrowser
    utorrent
    virtualbox
    vnc-viewer
    baidunetdisk
)

# Install apps to /Applications
# Default is: /Users/$user/Applications
echo "installing apps..."
brew cask install ${apps[@]}

echo "installing dotfiles..."
export RCRC="$HOME/dotfiles/rcrc"
rcup

echo "installing dotfiles-oschina..."
export RCRC="$HOME/dotfiles-oschina/rcrc"
rcup

