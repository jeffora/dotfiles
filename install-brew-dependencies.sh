#!/usr/bin/env bash

formula=(jq aws-vault openjdk htop gradle 1password-cli gh)

if [[ -f "$(which brew)" ]]; then
  for i in ${formula[@]}; do
    if ! brew list "$i" > /dev/null; then
      echo "➡️  installing $i"
      brew install "$i"
    else
      echo "✅ $i installed"
    fi
  done
else
  echo "brew not found, skipping setup"
fi

