alias ls="ls -lGFh"
alias ll="ls -alGFh"
alias shrug="echo '¯\_(ツ)_/¯'"

alias myip="dig +short myip.opendns.com A @resolver1.opendns.com"

alias localip="ifconfig | grep \"inet \" | grep -v 127.0.0.1 | cut -d\\  -f2"


disk-usage() {
  du -ms "$@"/* | sort -n
}
