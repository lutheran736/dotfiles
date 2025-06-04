#!/usr/bin/env zsh

# --- Environment Setup ---
() {
  # Ensure XDG directories exist
  local cache_dir="${XDG_CACHE_HOME:-$HOME/.cache}/zsh"
  [[ -d "$cache_dir" ]] || mkdir -p "$cache_dir"

  # Set important file paths
  typeset -g HISTFILE="${cache_dir}/history"
  typeset -g ZCOMPDUMP="${cache_dir}/zcompdump"
  typeset -g ZSH_CACHE_DIR="${XDG_CACHE_HOME:-$HOME/.cache}/zsh"
}



# --- Load User Configurations ---
() {
  local config_dir="${XDG_CONFIG_HOME:-$HOME/.config}/shell"
  local files=(
    shortcutrc
    shortcutenvrc
    aliasrc
    zshnameddirrc
    fzfrc
  )

  for file in "${files[@]}"; do
    [[ -f "$config_dir/$file" ]] && source "$config_dir/$file"
  done
}

# --- ZSH Options ---
() {
  # History
  setopt append_history inc_append_history hist_ignore_all_dups histreduceblanks sharehistory
  HISTSIZE=10000000
  SAVEHIST=10000000

  # Navigation
  setopt auto_cd auto_pushd pushd_ignore_dups pushd_minus

  # Completion
  setopt auto_menu menu_complete auto_param_slash complete_in_word

  # Globbing
  setopt extended_glob no_case_glob no_case_match numeric_glob_sort glob_dots

  # Other
  setopt interactive_comments
  unsetopt prompt_sp beep flow_control
}

# --- Completion System ---
() {
  autoload -Uz compinit bashcompinit
  zmodload zsh/complist

  # Only run compinit once per day
  if [[ -n ${ZCOMPDUMP}(#qN.mh+24) ]]; then
    compinit -d "$ZCOMPDUMP"
  else
    compinit -C -d "$ZCOMPDUMP"
  fi
  bashcompinit

  # Completion styles
  zstyle ':completion:*' completer _expand _complete _ignored _approximate
  zstyle ':completion:*' menu select
  zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
  zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'
  zstyle ':completion:*' rehash true
  zstyle ':completion:*' use-cache yes
  zstyle ':completion:*' cache-path "$ZSH_CACHE_DIR"
}


# --- Prompt ---
PS1='%F{blue}%B%~%b%f %F{green}❯%f '

# --- Title ---
precmd () { print -Pn "\e]2;%-3~\a"; }

# --- VI Mode ---
() {
  bindkey -v
  export KEYTIMEOUT=1

  # Cursor shaping
  function zle-keymap-select () {
    case $KEYMAP in
        vicmd) printf '\e[1 q';;      # block
        viins|main) printf '\e[5 q';; # beam
    esac
}
  zle -N zle-keymap-select
zle-line-init() {
    zle -K viins
    printf "\e[5 q"
}
  zle -N zle-line-init
  printf '\e[5 q'
  preexec() { printf '\e[5 q' ;}

  # Fix backspace
  bindkey -v '^?' backward-delete-char

  # Menu selection
  autoload -Uz complist
  bindkey -M menuselect 'h' vi-backward-char
  bindkey -M menuselect 'k' vi-up-line-or-history
  bindkey -M menuselect 'l' vi-forward-char
  bindkey -M menuselect 'j' vi-down-line-or-history

  # Edit command line
  autoload -Uz edit-command-line
  zle -N edit-command-line
  bindkey -M vicmd '^[[P' vi-delete-char
  bindkey -M vicmd '^e' edit-command-line
  bindkey -M visual '^[[P' vi-delete
}

# --- Key Bindings ---
bindkey '^[[H' beginning-of-line
bindkey '^[[4~' end-of-line
bindkey '^[[1~' beginning-of-line

# --- Directory Navigation ---
lfcd() {
  local tmp dir
  tmp="$(mktemp -uq)"
  trap 'rm -f $tmp >/dev/null 2>&1' EXIT
  lf -last-dir-path="$tmp" "$@"
  [[ -f "$tmp" ]] && dir="$(< "$tmp")" && [[ -d "$dir" ]] && [[ "$dir" != "$(pwd)" ]] && cd "$dir"
}
bindkey -s '^o' '^ulfcd\n'

# Command bindings
bindkey -s '^b' '^ucommand bc -lq\n'


# --- Plugins ---
() {
  local -A plugins=(
    syntax-highlighting "/usr/share/zsh/plugins/fast-syntax-highlighting/fast-syntax-highlighting.plugin.zsh"
    autosuggestions "/usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh"
  )

  for plugin in "${(@k)plugins}"; do
    [[ -f "${plugins[$plugin]}" ]] && source "${plugins[$plugin]}"
  done

  (( ${+ZSH_AUTOSUGGEST_STRATEGY} )) && {
    ZSH_AUTOSUGGEST_STRATEGY=(history completion)
    ZSH_AUTOSUGGEST_BUFFER_MAX_SIZE="20"
    ZSH_AUTOSUGGEST_USE_ASYNC=1
    bindkey '^ ' autosuggest-accept
    bindkey '^n' autosuggest-execute
  }
}

# --- fzf ---
(( ${+commands[fzf]} )) && source <(fzf --zsh)
