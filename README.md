# Wallpaper
This repository will create a daemon on macOS that will automatically update the desktop wallpaper at a set interval of time. It makes use of the [Unsplash](https://unsplash.com/) API in order to pull new, high-quality images to use as the wallpaper. Users will have to create an account in order to obtain your own access key for the API (Unsplash does not allow for the public dissemination of access keys, so I cannot include mine in this repository)


---
#### Usage
Start:

<pre>
make UNSPLASH_ACCESS_KEY=<i>your_API_key</i> [query="<i>your_query</i>"] [interval=<i>your_interval</i>]
</pre>

* *your_API_key*
	* Insert your own Unsplash API access key
	* Required
* *your_query*
	* Insert a query for the wallpapers
	* Must put inside double-quotes and have a single space between each word
		* Ex: "nature clouds bright"
	* Defaults to "nature landscape vibrant"
	* Optional
* *your_interval*
	* The interval at which the wallpaper will be updated (in seconds)
	* Defaults to 86400 (one day)
	* Optional

Stop:
<pre>
make stop
</pre>