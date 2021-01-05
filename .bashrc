# sudo autocomplete
complete -cf sudo

# disable duplicates in history
export HISTCONTROL=ignoredups

# custom bash prompt
echo_success () {
  if (( $? == 0))
  then
    echo -n -e "\e[92m✓\e[0m"
  else
    echo -n -e "\e[91mx\e[0m"
  fi
}

echo_git () {
    echo -n -e "\033[90m$(git branch 2>/dev/null | sed -n "s/* \(.*\)/\1 /p ")\033[0m"
}

PS1='$(echo_success) bwg\033[90m@\033[94m\h \033[96m\w\033[0m $(echo_git)\n-> '

# fzf
export FZF_DEFAULT_COMMAND="find -L ! -path '*.git*' ! -path '*.mypy_cache*' ! -path '*__pycache__*' ! -path '*node_modules*' ! -path '*_build*'"

# input rate
xset r rate 200 30

# editor settings
export EDITOR="nvim"
export VISUAL="nvim"
