# Dotfiles and OS Configurations
## Modules
To install configuration files for different programs/modules use `setup.sh`.

## Dependencies
### Bash

| Package | Info |
| --- | --- |
| starship | Prompt (gets installed with setup.sh) |
| ghostty | Terminal emulator of choice |

### Neovim

| Package | Info |
| --- | --- |
| nvim | Text editor |
| gcc | C/C++ compiler |
| fzf | Fuzzy finder |
| rgrep | Recursive grep |
| nerd-font-icons | Fonts with icons|

### Hyprland
> [!NOTE]
> Hyprland is a bleeding edge WM on Wayland. This meens it will not work as well with stable release distros.
> Some distros can work around this like Fedora with a [Copr repository](https://copr.fedorainfracloud.org/coprs/solopasha/hyprland).

| Package | Info |
| --- | --- |
| hyprland | WM |
| hyprpanel | Activity panel |
| hyprlock | Lockscreen |
| swww | Wallpaper manager |
| wofi | Launcher |

> [!NOTE]
> Reload hyprland config with `hyprctl reload`

### Language

| Package | Info |
| --- | --- |
| golang | Go programming language |

### Emacs
> [!WARNING]
> This is an old module. No longer guaranteed to work.

