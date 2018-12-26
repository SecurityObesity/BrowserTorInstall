#!/bin/bash
# Copyright © 2018
# Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"),
# to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense,
# and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:
# The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM,
# DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

# Run this script in Linux Terminal without elevated permissions.
# Make sure you make this script executable.
# You are able to the destination IP or domain name to check internet connectivity.

if ping -q -c 1 -W 1 8.8.8.8 > /dev/null; then
	echo "[OK] Checking for internet connectivity"
else
	echo "No internet connection is currently proper available."
	exit
fi

ARCH=$(uname -m)
if [[ $ARCH -eq "x86_64" ]]
then
	ARCH="linux64"
else
	ARCH="linux32"
fi

options=("English" "Arabic" "Catalian" "Danish" "German" "Spanish" "Farsi" "French" "Irish" "Hebrew" "Indonesian" "Icelandic" "Italian" "Japanese" "Korean" "Norwegian" "Dutch" "Polish" "Portuguese" "Russian" "Swedish" "Turkish" "Vietnamese" "Simplified Chinese" "Traditional Chinese" "English")
langCode=("en-US" "ar" "ca" "da" "de" "es-ES" "fa" "fr" "ga-IE" "he" "id" "is" "it" "ja" "ko" "nb-NO" "nl" "pl" "pt-BR" "ru" "sv-SE" "tr" "vi" "zh-CN" "zh-TW" "en-US")
torbrowserVersion="8.0.4"

echo "Tor Browser Automation Install Script"
echo "Developed by @dexoidan"
echo

select opt in "${options[@]}"; do
	if [[ -n $REPLY ]]; then
		url="https://www.torproject.org/dist/torbrowser/"$torbrowserVersion"/tor-browser-"$ARCH"-"$torbrowserVersion"_"${langCode[$REPLY-1]}".tar.xz"
		filename="tor-browser-"$ARCH"-"$torbrowserVersion"_"${langCode[$REPLY-1]}".tar.xz"
		foldername="tor-browser_"${langCode[$REPLY-1]}
		if [ -e $filename ]; then rm -rf $filename; fi
		echo "Downloading Tor Browser..."
		curl -# -LO "$url"
		echo "Done."
		echo "Applying permissions to "$filename"..."
		chown $USER:$USER $filename
		chmod +x $filename
		if [ -d $foldername ]; then rm -rf $foldername; fi
		echo "Extracting the compressed archive onto the current folder..."
		tar -xf $filename
		echo "Done."
		echo "Removing the Tor Browser installation archive..."
		rm -rf $filename
		echo "Done."
		echo
		echo "You should be able to launching the Tor Browser using ./start-tor-browser.desktop"
		echo "Tor Browser is unpacked to a local folder. Please copy this folder onto the installation destination."
		echo "You do not need to copying the folder to another folderpath destination. You are able to run the Tor Browser from an USB."
		echo "Make sure you can run the Application from the Desktop shortcut in the local folder. Have fun with using Tor Browser."
		echo
		echo "if you have any issues that makes Tor Browser not work properly. Contact TorProject for getting help."
		echo "Contact information can be found at this webpage: https://www.torproject.org/about/contact.html.en"
		echo "If this script does not work, then don't worry. You are able to manually download and install Tor Browser."
		break
	fi
done