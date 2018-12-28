# Load GRML zsh config
[[ -s "$HOME/.zshrc_grml" ]] && source "$HOME/.zshrc_grml"

# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=5000
SAVEHIST=5000
setopt appendhistory hist_expire_dups_first autocd
bindkey -e
# End of lines configured by zsh-newuser-install
# The following lines were added by compinstall
zstyle :compinstall filename "$HOME/.zshrc"

autoload -Uz compinit
compinit
# End of lines added by compinstall

export TIMEFMT="
%J  user:%*U kernel:%*S CPU:%P total:%*Es
    MEM:  alloc:%MMB stack:%DKB
    IO: read:%I write:%O sock rec:%r sock send:%s"

alias undecorate='xprop -f _MOTIF_WM_HINTS 32c -set _MOTIF_WM_HINTS "0x2, 0x0, 0x0, 0x0, 0x0"'
alias redecorate='xprop -f _MOTIF_WM_HINTS 32c -set _MOTIF_WM_HINTS "0x2, 0x0, 0x1, 0x0, 0x0"'

assh() {autossh -M 0 -o "ServerAliveInterval 15" -o "ServerAliveCountMax 2" $*}
addl() {aria2c -x5 $*}
adl() {addl --http-proxy="http://127.0.0.1:3213" $*}
novpn() {sudo route add $1 gw rasp dev wlan0}
