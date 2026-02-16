#!/bin/bash

# Detect macOS version
MACOS_VERSION=$(sw_vers -productVersion | cut -d. -f1)
THRESHOLD=14

if [ "$MACOS_VERSION" -lt "$THRESHOLD" ]; then
    PM="port"
else
    PM="brew"
fi

echo "Detected macOS version $MACOS_VERSION. Using $PM for package management."

xcode-select --install
# Install Package Manager if missing
if [ "$PM" == "brew" ]; then
    if ! command -v brew >/dev/null 2>&1; then
        echo "Installing Homebrew..."
        /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    fi
    echo "Updating Homebrew..."
    brew update
elif [ "$PM" == "port" ]; then
    if ! command -v port >/dev/null 2>&1; then
        echo "MacPorts not found. Please install it from https://www.macports.org/install.php"
        exit 1
    fi
    echo "Updating MacPorts..."
    sudo port selfupdate
fi

# Change shell to zsh if not already
if [[ "$SHELL" != */zsh ]]; then
    echo "Changing shell to zsh..."
    chsh -s "$(which zsh)"
fi

# Package Lists
binaries=(
    rcm
    tree
    socat
    nmap
    zsh
    zsh-completions
    tmux
    cmake
    clang-format
)

apps=(
    vnc-viewer
)

# Installation Logic
if [ "$PM" == "brew" ]; then
    echo "Installing binaries via Homebrew..."
    brew install "${binaries[@]}"

    echo "Installing apps via Homebrew Cask..."
    brew install --cask "${apps[@]}"
elif [ "$PM" == "port" ]; then
    echo "Installing binaries via MacPorts..."
    for pkg in "${binaries[@]}"; do
        case "$pkg" in
            telnet) port_pkg="inetutils" ;;
            *) port_pkg="$pkg" ;;
        esac
        echo "Installing $port_pkg..."
        sudo port install "$port_pkg"
    done
    
    echo "Note: MacPorts does not support Cask-like app installations for all GUI apps."
    echo "Please install these manually if needed: ${apps[*]}"
fi

# Dotfiles installation
echo "Installing dotfiles..."
if command -v rcup >/dev/null 2>&1; then
    export RCRC="$HOME/dotfiles/rcrc"
    rcup -f
    
    if [ -d "$HOME/dotfiles-oschina" ]; then
        echo "Installing dotfiles-oschina..."
        export RCRC="$HOME/dotfiles-oschina/rcrc"
        rcup -f
    fi
else
    echo "rcup not found. Please ensure rcm is installed correctly."
fi

echo "Cleanup..."
if [ "$PM" == "brew" ]; then
    brew cleanup
fi
