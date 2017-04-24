#!/bin/bash

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

echo "source $DIR/script/notkid_zsh.sh" >> ~/.zshrc

printf "Install finished"
