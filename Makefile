.PHONY: init theme

init:
	./init.sh

theme:
	mkdir -p ~/Library/Developer/Xcode/UserData/FontAndColorThemes
	curl -L -O https://github.com/dracula/xcode/archive/master.zip
	unzip master.zip
	rm -f master.zip
	mv xcode-master/Dracula.xccolortheme ~/Library/Developer/Xcode/UserData/FontAndColorThemes/
	rm -fr xcode-master

