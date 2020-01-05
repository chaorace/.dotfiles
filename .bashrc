#!/usr/bin/env bash
export PS1='\w λ '
export PATH="${PATH}:$HOME/.emacs.d/bin"
alias emacs='emacsclient -c -n -e'
export EDITOR='/usr/bin/emacsclient -c -n -e'
export LPASS_AGENT_TIMEOUT=28800

# dotfiles git magic
alias dotfiles='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'
[ -f /usr/share/bash-completion/completions/git ] && . /usr/share/bash-completion/completions/git
__git_complete dotfiles _git
