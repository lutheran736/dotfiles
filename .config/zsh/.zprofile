#/bin/sh
[ ! -d "$XDG_DATA_HOME/xorg" ] && mkdir -p "$XDG_DATA_HOME/xorg"
[ "$(tty)" = "/dev/tty1" ] && ! pidof -s Xorg >/dev/null 2>&1 && exec startx "$XINITRC" -- -keeptty > "$XDG_DATA_HOME/xorg/xorg.log" 2>&1
