#!/usr/bin/env bash

go build -o mover main.go
ln -sf ~/dotfiles/mover/com.maxi.mover.plist ~/Library/LaunchAgents/com.maxi.mover.plist && echo "  - Linked mover.plist"
launchctl load ~/Library/LaunchAgents/com.maxi.mover.plist
launchctl list | grep mover


