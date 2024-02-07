#!/bin/sh

yabai -m space --create
new_space_index=$(yabai -m query --spaces | jq 'map(select(.type == "bsp").index) | last')
current_space_index=$(yabai -m query --spaces | jq 'map(select(."has-focus" == true).index) | last')

echo $new_space_index
echo $current_space_index

if [ $1 = "left" ]; then
    # if $(($current_space_index - 1))=-1 then
    #     yabai -m space $new_space_index --move 1
    # else
    yabai -m space $new_space_index --move $current_space_index
    yabai -m space --focus $current_space_index
    # fi
elif [ $1 = "right" ]; then
    yabai -m space $new_space_index --move $(($current_space_index + 1))
    yabai -m space --focus $(($current_space_index + 1))
else
    echo "Invalid argument"
fi
