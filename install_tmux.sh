#!/usr/bin/env bash
# =============================================================================
# install_tmux.sh — Multi-platform tmux installer
# Platforms: macOS (Homebrew, MacPorts), Debian/Ubuntu, RHEL/Fedora/CentOS,
#            Arch Linux, Alpine Linux, openSUSE, FreeBSD, OpenBSD, NetBSD
# =============================================================================

set -euo pipefail

# ── Helpers ──────────────────────────────────────────────────────────────────

info()    { printf '\033[0;34m[INFO]\033[0m  %s\n' "$*"; }
success() { printf '\033[0;32m[OK]\033[0m    %s\n' "$*"; }
warn()    { printf '\033[0;33m[WARN]\033[0m  %s\n' "$*"; }
error()   { printf '\033[0;31m[ERROR]\033[0m %s\n' "$*" >&2; exit 1; }

have() { command -v "$1" &>/dev/null; }

# ── Already installed? ───────────────────────────────────────────────────────

if have tmux; then
    TMUX_VER=$(tmux -V)
    success "tmux is already installed: $TMUX_VER"
    exit 0
fi

# ── Detect OS ────────────────────────────────────────────────────────────────

OS="$(uname -s)"
info "Detected OS: $OS"

# ── macOS ─────────────────────────────────────────────────────────────────────

install_macos() {
    # Prefer Homebrew, fall back to MacPorts, then offer to install Homebrew
    if have brew; then
        info "Using Homebrew to install tmux…"
        brew install tmux

    elif have port; then
        info "Using MacPorts to install tmux…"
        # MacPorts typically needs sudo
        sudo port install tmux

    else
        warn "Neither Homebrew nor MacPorts was found."
        echo ""
        echo "Choose an installer to set up first:"
        echo "  1) Homebrew  — https://brew.sh"
        echo "  2) MacPorts  — https://www.macports.org"
        echo "  q) Quit"
        echo ""
        read -rp "Your choice [1/2/q]: " choice
        case "$choice" in
            1)
                info "Installing Homebrew…"
                /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
                info "Installing tmux via Homebrew…"
                brew install tmux
                ;;
            2)
                error "Please install MacPorts manually from https://www.macports.org/install.php, then re-run this script."
                ;;
            *)
                error "Aborted. Install Homebrew or MacPorts first, then re-run this script."
                ;;
        esac
    fi
}

# ── Linux ─────────────────────────────────────────────────────────────────────

install_linux() {
    if [ ! -f /etc/os-release ]; then
        error "Cannot detect Linux distribution (no /etc/os-release)."
    fi

    # shellcheck disable=SC1091
    . /etc/os-release
    DISTRO="${ID:-unknown}"
    info "Linux distro: $DISTRO (${PRETTY_NAME:-})"

    case "$DISTRO" in
        # ── Debian / Ubuntu / Raspberry Pi OS ──
        debian|ubuntu|raspbian|linuxmint|pop|elementary|kali|parrot|zorin)
            info "Using apt to install tmux…"
            sudo apt-get update -qq
            sudo apt-get install -y tmux
            ;;

        # ── RHEL / CentOS / Fedora / Rocky / Alma ──
        fedora)
            info "Using dnf to install tmux…"
            sudo dnf install -y tmux
            ;;
        rhel|centos|rocky|almalinux|ol)
            # Try dnf first (RHEL 8+), fall back to yum
            if have dnf; then
                info "Using dnf to install tmux…"
                sudo dnf install -y tmux
            else
                info "Using yum to install tmux…"
                sudo yum install -y tmux
            fi
            ;;

        # ── Arch / Manjaro ──
        arch|manjaro|endeavouros|garuda)
            info "Using pacman to install tmux…"
            sudo pacman -Sy --noconfirm tmux
            ;;

        # ── Alpine ──
        alpine)
            info "Using apk to install tmux…"
            sudo apk add --no-cache tmux
            ;;

        # ── openSUSE ──
        opensuse*|sles)
            info "Using zypper to install tmux…"
            sudo zypper install -y tmux
            ;;

        # ── Void Linux ──
        void)
            info "Using xbps-install to install tmux…"
            sudo xbps-install -Sy tmux
            ;;

        # ── Gentoo ──
        gentoo)
            info "Using emerge to install tmux…"
            sudo emerge --ask=n app-misc/tmux
            ;;

        # ── NixOS ──
        nixos)
            warn "On NixOS, add tmux to your configuration.nix or run:"
            echo "  nix-env -iA nixpkgs.tmux"
            exit 0
            ;;

        *)
            warn "Unknown distro '$DISTRO'. Trying common package managers…"
            if   have apt-get; then sudo apt-get update -qq && sudo apt-get install -y tmux
            elif have dnf;     then sudo dnf install -y tmux
            elif have yum;     then sudo yum install -y tmux
            elif have pacman;  then sudo pacman -Sy --noconfirm tmux
            elif have apk;     then sudo apk add --no-cache tmux
            elif have zypper;  then sudo zypper install -y tmux
            else
                error "No recognised package manager found. Please install tmux manually."
            fi
            ;;
    esac
}

# ── BSD ───────────────────────────────────────────────────────────────────────

install_freebsd() {
    info "Using pkg to install tmux on FreeBSD…"
    sudo pkg install -y tmux
}

install_openbsd() {
    info "Using pkg_add to install tmux on OpenBSD…"
    sudo pkg_add tmux
}

install_netbsd() {
    if have pkgin; then
        info "Using pkgin to install tmux on NetBSD…"
        sudo pkgin -y install tmux
    else
        info "Using pkg_add to install tmux on NetBSD…"
        sudo pkg_add tmux
    fi
}

# ── Dispatch ──────────────────────────────────────────────────────────────────

case "$OS" in
    Darwin)  install_macos   ;;
    Linux)   install_linux   ;;
    FreeBSD) install_freebsd ;;
    OpenBSD) install_openbsd ;;
    NetBSD)  install_netbsd  ;;
    *)       error "Unsupported OS: $OS" ;;
esac

# ── Verify ────────────────────────────────────────────────────────────────────

if have tmux; then
    success "Installation complete! $(tmux -V)"
else
    error "tmux installation appears to have failed. Please check the output above."
fi
