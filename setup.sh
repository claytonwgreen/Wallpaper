#!/bin/bash

if [[ -z "${UNSPLASH_ACCESS_KEY}" ]]; then 
	# exit if API key is not present
	echo "Sorry, you must pass your Unsplash API key in by adding \"UNSPLASH_ACCESS_KEY=your_api_key_here\" to your call to make" 
	exit 1 
else 
	# insert current directory path into config file so that newWallpaper.sh script can be run
	directory="$(pwd)"; 
	sed -i.bak "s;DIRECTORY_REPLACE;${directory};" com.personal.newWallpaper.plist 

	# insert API key into config file so that newWallpaper.sh script can use it
	sed -i.bak.bak "s;API_KEY_REPLACE;${UNSPLASH_ACCESS_KEY};" com.personal.newWallpaper.plist

	# insert interval when wallpaper should be updated (default is once per day)
	if [[ -z "${interval}" ]]; then
		sed -i.bak.bak "s;INTERVAL_REPLACE;86400;" com.personal.newWallpaper.plist
	else
		sed -i.bak.bak "s;INTERVAL_REPLACE;${interval};" com.personal.newWallpaper.plist
	fi

	# insert query string for wallpaper (default is "nature+landscape+vibrant")
	if [[ -z "${query}" ]]; then
		sed -i.bak.bak "s;QUERY_REPLACE;nature+landscape+vibrant;" com.personal.newWallpaper.plist
	else
		temp="$(echo $query | sed "s; ;+;")"
		echo $temp
		sed -i.bak.bak "s;QUERY_REPLACE;${temp};" com.personal.newWallpaper.plist
	fi

	# move config file into LaunchAgents library
	mv com.personal.newWallpaper.plist ~/Library/LaunchAgents/com.personal.newWallpaper.plist

	# replace template config file in this directory
	mv com.personal.newWallpaper.plist.bak com.personal.newWallpaper.plist

	# delete backup
	rm com.personal.newWallpaper.plist.bak.bak

	# start up agent that will replace wallpaper
	launchctl load ~/Library/LaunchAgents/com.personal.newWallpaper.plist

	exit 0 
fi