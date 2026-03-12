if command -v eza &> /dev/null; then
  alias ls="eza --icons --group-directories-first"
  alias ll="eza -la --icons --group-directories-first --git"
  alias tree="eza --tree --icons --level=3"
else
  alias ls="ls -lGFh"
  alias ll="ls -alGFh"
fi

if command -v bat &> /dev/null; then
  alias cat="bat --paging=never"
fi

alias shrug="echo '¯\_(ツ)_/¯'"

alias myip="dig +short myip.opendns.com A @resolver1.opendns.com"

alias localip="ifconfig | grep \"inet \" | grep -v 127.0.0.1 | cut -d\\  -f2"


disk-usage() {
  du -ms "$@"/* | sort -n
}
