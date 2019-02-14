#!/bin/sh
# Check for Homebrew,
# Install if we don't have it
if test ! $(which brew); then
	echo "Installing homebrew..."
	ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
fi

chsh -s $(which zsh)
# Update homebrew recipes
# FAQ1:sudo chown -R $(whoami):admin /usr/local/Homebrew/.git
echo "updating brew..."
#brew update

#taps

taps=(
	thoughtbot/formulae
)
echo "installing binaries..."
echo "browse from http://braumeister.org"
brew tap ${taps[@]}

brew cleanup

binaries=(
#	cntlm
#	htop
	rcm
#	mackup
	macvim
#	"wget --with-iri"
	tree
	socat
	node
	nmap
#	e2fsprogs
#	neofetch
#	"reattach-to-user-namespace --with-wrap-pbcopy-and-pbpaste"
	zsh
	zsh-completions
	tmux
#	graphviz
#	bazel
	cmake
	clang-format
    telnet
)

echo "installing binaries..."
brew install ${binaries[@]}

brew cleanup

# Apps
apps=(
    appcleaner
    #evernote
    #google-chrome
    #qq
    qqmusic
    #neteasemusic
    #skitch
    #vlc
    #mplayerx
    keycastr
    #beyond-compare
    #aliwangwang
    #calibre
    #coderunner
    #filezilla
    #geektool
    gitup
    #hex-fiend
    #keepassx
    #nutstore
    #shadowsocksx
    #staruml
    #torbrowser
    #virtualbox
    vnc-viewer
    #baidunetdisk
    #postman
    #wireshark
    #dukto
    #mysqlworkbench
    #pycharm-ce
    #visual-studio-code
    #hammerspoon
    #downie
    #sourcetree
    #spectacle
    #amethyst
    #android-platform-tools
)

# Install apps to /Applications
# Default is: /Users/$user/Applications
echo "installing apps..."
echo "browse https://caskroom.github.io/search"
brew cask install ${apps[@]}
brew cask install caskroom/versions/java8

echo "installing dotfiles..."
export RCRC="$HOME/dotfiles/rcrc"
rcup

echo "installing dotfiles-oschina..."
export RCRC="$HOME/dotfiles-oschina/rcrc"
rcup

