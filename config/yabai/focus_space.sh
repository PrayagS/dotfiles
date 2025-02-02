#!/bin/bash

# DISCLAIMER: Qwen assisted in writing this script

# Function to create a space
create_space() {
    local index=$1
    yabai -m space --create
    echo "Created new space $index"
}

# Function to focus a space by number or direction
focus_space() {
    local target=$1
    if [[ "$target" =~ ^[0-9]+$ ]]; then
        # Focus space by number
        space_exists=$(yabai -m query --spaces --space "$target")
        if [ -z "$space_exists" ]; then
            create_space "$target"
            focus_space "$target"
        else
            yabai -m space --focus "$target"
            echo "Focused space $target"
        fi
    elif [[ "$target" == "left" ]] || [[ "$target" == "right" ]]; then
        # Move left or right and wrap around
        current_space_index=$(yabai -m query --spaces | jq 'map(select(."has-focus" == true).index) | last')

        if [ "$target" == "left" ]; then
            new_index=$((current_space_index - 1))
            if [ "$new_index" -lt 1 ]; then
                new_index=$((new_index + 10))
            fi
        elif [ "$target" == "right" ]; then
            new_index=$((current_space_index + 1))
            if [ "$new_index" -gt 10 ]; then
                new_index=$((new_index - 10))
            fi
        else
            echo "Invalid direction. Use 'left' or 'right'."
            exit 1
        fi

        focus_space "$new_index"
    else
        echo "Invalid argument. Use --space <number> or --space left/right"
        exit 1
    fi
}

# Function to move the current window to a specified space
move_window_to_space() {
    local target=$1
    if [[ "$target" =~ ^[0-9]+$ ]]; then
        # Move window to space by number
        space_exists=$(yabai -m query --spaces --space "$target")
        if [ -z "$space_exists" ]; then
            create_space "$target"
            move_window_to_space "$target" "$2"
        else
            yabai -m window --space "$target"
            if [[ "$2" == "--focus" ]]; then
                yabai -m space --focus "$target"
                echo "Moved window to space $target and focused it"
            else
                echo "Moved window to space $target"
            fi
        fi
    elif [[ "$target" == "left" ]] || [[ "$target" == "right" ]]; then
        # Move left or right and wrap around
        current_space_index=$(yabai -m query --spaces | jq 'map(select(."has-focus" == true).index) | last')

        if [ "$target" == "left" ]; then
            new_index=$((current_space_index - 1))
            if [ "$new_index" -lt 1 ]; then
                new_index=$((new_index + 10))
            fi
        elif [ "$target" == "right" ]; then
            new_index=$((current_space_index + 1))
            if [ "$new_index" -gt 10 ]; then
                new_index=$((new_index - 10))
            fi
        else
            echo "Invalid direction. Use 'left' or 'right'."
            exit 1
        fi

        move_window_to_space "$new_index" "$2"
    else
        echo "Invalid argument. Use --space <number> or --space left/right"
        exit 1
    fi
}

# Main script logic
# if [ "$#" -ne 4 ]; then
#     echo "Usage: $0 -m <space/window> --<focus/move> <number|left|right>"
#     exit 1
# fi

mode=$2
action=$3
target=$4

case $mode in
    space)
        case $action in
            --focus)
                focus_space "$target"
                ;;
            *)
                echo "Invalid action. Use --focus <number|left|right>"
                exit 1
                ;;
        esac
        ;;
    window)
        case $action in
            --move)
                move_window_to_space "$target" "$5"
                ;;
            *)
                echo "Invalid action. Use --move <number|left|right> or --focus <number|left|right>"
                exit 1
                ;;
        esac
        ;;
    *)
        echo "Invalid mode. Use -m <space/window>"
        exit 1
        ;;
esac
