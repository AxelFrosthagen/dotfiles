#! /bin/bash
export WAYLAND_DISPLAY=wayland-1

# Wallpaper transition config:
transition='--transition-type any --transition-fps 30 --transition-step 30';

current=$((swww query | grep -m 1 -o 'image: .*') | cut -d' ' -f2 );
#echo 'Current image: ' $current;

filesString=$( find "$HOME/dotfiles/assets/wallpapers" -type f );
files=($filesString);

for (( i=0; i < ${#files[@]} - 1; i++ )); do
    if [[ ${files[$i]} == $current ]]; then
        #echo 'this ' ${files[$i+1]};
        swww img ${files[$i+1]} $transition;
        exit 0;
    #else
        #echo 'not this ' ${files[$i]};
    fi;

done;

#echo 'this ' ${files[0]};
swww img ${files[0]} $transition;
