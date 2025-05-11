#!/bin/bash

MACOS_FIREFOX_DIR="$HOME/Library/Application Support/Firefox"

rg --no-line-number 'Default=Profiles' "$MACOS_FIREFOX_DIR/profiles.ini" | \
    cut -d'/' -f2
