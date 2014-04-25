# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000
setopt appendhistory autocd
bindkey -e
# End of lines configured by zsh-newuser-install
# The following lines were added by compinstall
zstyle :compinstall filename '/home/darki/.zshrc'

autoload -Uz compinit
compinit
# End of lines added by compinstall

export TIMEFMT="
%J  user:%*U kernel:%*S CPU:%P total:%*Es
    MEM:  alloc:%MMB stack:%DKB
    IO: read:%I write:%O sock rec:%r sock send:%s"

assh() {autossh -M 0 -o "ServerAliveInterval 15" -o "ServerAliveCountMax 2" $*}
addl() {aria2c -x5 $*}
adl() {addl --http-proxy="http://127.0.0.1:3213" $*}
novpn() {sudo route add $1 gw rasp dev wlan0}
getkscm() {svn co svn+ssh://koala/$*}
proxy() {
  echo -n 'pass: '
  read pass
  export http_proxy="http://darki:$pass@91.121.208.161:3128/"
  export https_proxy="$http_proxy"
}
