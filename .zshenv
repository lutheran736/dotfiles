#!/usr/bin/env zsh

# PATH configuration
export PATH="$PATH:$(find ~/.local/bin -type d | paste -sd ':')"

# Default applications
export EDITOR="nvim"
export TERMINAL="st"
export BROWSER="librewolf"
export OPENER="xdg-open"
export PAGER='less'

# XDG Base Directory Specification
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_CACHE_HOME="$HOME/.cache"
export XDG_STATE_HOME="$HOME/.local/state"

# X11 configuration files
export XINITRC="$XDG_CONFIG_HOME/x11/xinitrc"
export XPROFILE="$XDG_CONFIG_HOME/x11/xprofile"
export XRESOURCES="$XDG_CONFIG_HOME/x11/xresources"

# Application configurations
export NOTMUCH_CONFIG="$XDG_CONFIG_HOME/notmuch-config"
export GTK2_RC_FILES="$XDG_CONFIG_HOME/gtk-2.0/gtkrc-2.0"
export WGETRC="$XDG_CONFIG_HOME/wget/wgetrc"
export INPUTRC="$XDG_CONFIG_HOME/shell/inputrc"
export ZDOTDIR="$XDG_CONFIG_HOME/zsh"
export PASSWORD_STORE_DIR="$XDG_DATA_HOME/password-store"
export GNUPGHOME="$XDG_DATA_HOME/gnupg"
export HISTFILE="$XDG_DATA_HOME/history"
export ELECTRUMDIR="$XDG_DATA_HOME/electrum"
export PYTHONSTARTUP="$XDG_CONFIG_HOME/python/pythonrc"
export NPM_CONFIG_USERCONFIG="$XDG_CONFIG_HOME/npm/npmrc"
export MBSYNCRC="$XDG_CONFIG_HOME/mbsync/config"
export WINEPREFIX="$XDG_DATA_HOME/wineprefixes/default"
export INPUTRC="$XDG_CONFIG_HOME/shell/inputrc"
export ANDROID_SDK_HOME="$XDG_CONFIG_HOME/android"
export SQLITE_HISTORY="$XDG_DATA_HOME/sqlite_history"
export GRADLE_USER_HOME="$XDG_DATA_HOME"/gradle
export NVM_DIR="$XDG_DATA_HOME"/nvm
export PARALLEL_HOME="$XDG_CONFIG_HOME"/parallel
export LYNX_CFG="$XDG_CONFIG_HOME"/lynx/lynx.cfg
export LYNX_LSS="$XDG_CONFIG_HOME"/lynx/lynx.lss
export LESSHISTFILE="$XDG_CACHE_HOME/less_history"
export PYTHON_HISTORY="$XDG_DATA_HOME/python/history"
export GRADLE_USER_HOME="$XDG_DATA_HOME/gradle"
export FFMPEG_DATADIR="$XDG_CONFIG_HOME/ffmpeg"
export TEXMFHOME="$XDG_DATA_HOME/texmf"
export TEXMFVAR="$XDG_CACHE_HOME/texlive/texmf-var"
export MAVEN_ARGS="--settings $XDG_CONFIG_HOME/maven/settings.xml"
export MAVEN_OPTS=-Dmaven.repo.local="$XDG_DATA_HOME"/maven/repository
export CARGO_HOME="$XDG_DATA_HOME/cargo"
export GOPATH="$XDG_DATA_HOME/go"
export ANSIBLE_CONFIG="$XDG_CONFIG_HOME/ansible/ansible.cfg"
export UNISON="$XDG_DATA_HOME/unison"

# Java configuration
export _JAVA_OPTIONS=-Djava.util.prefs.userRoot="$XDG_CONFIG_HOME/java"
export AWT_TOOLKIT="MToolkit wmname LG3D"
export _JAVA_AWT_WM_NONREPARENTING=1

# Less & Man
export LESS='-i -x4 -M -R -~ --mouse --wheel-lines=4 --intr=q$ -PM ?f%f:[stdin]. ?m(%i/%m) .| %L lines | ?eBot:%Pb\%. | %lt-%lb $'
export LESS="$LESS -R --use-color -DsG\$ -DdB\$ -DuC\$ -DkG\$ -DEGb\$ -DNK\$ -DPGb\$ -DSyb\$ -DRK\$ -DMg\$ +Gg"
export LESSOPEN="|/usr/bin/highlight -O ansi %s 2>/dev/null"
export MANPAGER='less -m'
export MANLESS='man $MAN_PN | %L lines | ?eBot:%pb\%. | %lt-%lb'

# UI/UX settings
export SUDO_ASKPASS="$HOME/.local/bin/dmenupass"
export QT_QPA_PLATFORMTHEME="gtk3"
export GREP_COLORS='mt=38;5;3:mc=48;5;3;38;5;0:fn=38;5;14:ln=38;5;8:bn=38;5;4:se=1;38;5;5'
[ -f "$XDG_CONFIG_HOME/lscolors" ] && eval "$(dircolors "$XDG_CONFIG_HOME/lscolors")" || eval "$(dircolors)"

# System tweaks
[ ! -f "$XDG_CONFIG_HOME/shell/shortcutrc" ] && setsid -f shortcuts >/dev/null 2>&1
sudo -n loadkeys "$XDG_DATA_HOME/larbs/ttymaps.kmap" 2>/dev/null
