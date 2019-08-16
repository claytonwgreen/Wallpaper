#!/bin/bash

if [[ -z "${UNSPLASH_ACCESS_KEY}" ]]; then
	# if API key does not exist then abort
	echo "Sorry, you must have your Unsplash API key saved in the environemnt variable named UNSPLASH_ACCESS_KEY in the .plist file"
	exit 1
else
	# request random photo using search query
	response=$(curl -s "https://api.unsplash.com/photos/random?client_id=${UNSPLASH_ACCESS_KEY}&query=${PHOTO_QUERY}&orientation=landscape")
	
	# pull from the response the url where the photo can actually be downloaded and the photoid (for naming photo)
	url="$(echo "${response}" | jq -r '.urls.full')"
	name="$(echo "${response}" | jq -r '.id')"
	file="$(pwd)/${name}.jpg"

	# get name of old wallpaper so file can be removed after inserting new wallpaper
	old_file="$(ls *.jpg)"

	# download the new photo
	curl -o "${file}" "${url}"

	# set wallpaper to new downloaded photo
	cmd="tell application \"Finder\" to set desktop picture to \""${file}"\" as POSIX file"
	osascript -e "$cmd"

	# remove old photo
	rm -rf "${old_file}"

	# print success messages
	echo "removed ${old_file}"
	echo "Wallpaper updated"
fi