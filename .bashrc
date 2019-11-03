#!/usr/bin/env bash
export PS1='\w λ '
alias dotfiles='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'
export PATH="${PATH}:$HOME/.emacs.d/bin"
alias emacs='emacsclient -c -n -e'
export EDITOR='/usr/bin/emacsclient -c -n -e'
