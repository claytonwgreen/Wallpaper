SHELL := /bin/bash

default:
	@./setup.sh
	@echo Success!

stop:
	@launchctl unload ~/Library/LaunchAgents/com.personal.newWallpaper.plist
	@rm -f ~/Library/LaunchAgents/com.personal.newWallpaper.plist
	@echo Auto wallpaper updates shut down


