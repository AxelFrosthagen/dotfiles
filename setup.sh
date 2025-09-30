#! /bin/bash

# All modules and given setup in alfabetical order
declare -A modules=(\
    [test]="echo hello world" \
    [bashrc]="ln -fs ~/dotfiles/bashrc.sh ~/.bashrc" \
    [emacs]=emacs-setup \
    [ghostty]="ln -fs ~/dotfiles/ghostty/ ~/.config/" \
    [hyprland]=hyprland-setup \
    [nvim]="ln -fs ~/dotfiles/nvim/ ~/.config/" \
    [tmux]="ln -fs ~/dotfiles/tmux/ ~/.config/" \
);

emacs-setup() {
  ln -fs ~/dotfiles/emacs/init.el ~/.config/doom/init.el;
  ln -fs ~/dotfiles/emacs/config.el ~/.config/doom/config.el;
  ln -fs ~/dotfiles/emacs/packages.el ~/.config/doom/packages.el;
}

hyprland-setup() {
    ln -fs ~/dotfiles/hyprland/hypr/ ~/.config/;
    ln -fs ~/dotfiles/hyprland/hyprpanel/ ~/.config/;
    ln -fs ~/dotfiles/hyprland/wofi/ ~/.config/;
}

if [ -z $1 ]; then
    echo "Run with module to install config for";
    echo "    ./setup.sh ls";
    echo "    ./setup.sh nvim";
    exit 1;
fi;

if [[ $1 == "ls" ]]; then
    for module in "${!modules[@]}"; do
        printf "%s\n" ${module};
    done;
    exit 0;
fi;

eval ${modules[$1]}
