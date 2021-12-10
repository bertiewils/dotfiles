#!/usr/bin/env bash

[[ -r "/usr/local/etc/profile.d/bash_completion.sh" ]] && . "/usr/local/etc/profile.d/bash_completion.sh"

source ~/.bashrc
[ -f ~/.aliases ] && source ~/.aliases
[ -f ~/.functions ] && source ~/.functions
[ -f ~/.bash_prompt ] && source ~/.bash_prompt
[ -f ~/.aliases-priv ] && source ~/.aliases-priv
[ -f ~/.functions-priv ] && source ~/.functions-priv

export PATH="/usr/local/opt/python@3.7/bin:$PATH"
export PATH="/usr/local/opt/python@3.7:$PATH"
