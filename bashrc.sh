#
# ~/.bashrc
#

#
# STARSHIP PS1
#
eval "$(starship init bash)"
export STARSHIP_CONFIG=~/dotfiles/starship.toml

#
# PATHS
#
export PATH="$HOME/go/bin:$PATH"
export PATH="$HOME/.config/emacs/bin:$PATH"

#
# ALIASES
#
alias ls='ls --color=auto'
alias la='ls -a'
alias ll='ls -l'
alias la='ls -la'
alias grep='grep --color=auto'


