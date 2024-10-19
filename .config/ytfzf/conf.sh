ytdl_pref="bestvideo[height<=?800][fps<=?30][vcodec^=avc1][vcodec!=?vp9]+bestaudio/best"
ytfzf_hist=0 # history is on by default it can be set to -> 0 history off, 1: history on
ytfzf_loop=0 # if set to 1 it is on but normally it is off by default. can be turned on using option -l
ytfzf_enable_fzf_default_opts=1 # fzf colors are going to be the one from your fzf configuration
fzf_player=”mpv” # sets the video player used by ytfzf (mpv by default), e.g. fzf_player=”devour mpv”; you can also specify the ytfzf_player_format, e.g. ytfzf_player_format=”devour mpv –ytdl-format=”
