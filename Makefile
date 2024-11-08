.PHONY: init xcode

init:
	./init.sh

xcode:
	# theme
	mkdir -p ~/Library/Developer/Xcode/UserData/FontAndColorThemes
	curl -L -O https://github.com/dracula/xcode/archive/master.zip
	unzip master.zip
	rm -f master.zip
	mv xcode-master/Dracula.xccolortheme ~/Library/Developer/Xcode/UserData/FontAndColorThemes/
	rm -fr xcode-master
	# defaults
	defaults write com.apple.dt.Xcode XCFontAndColorCurrentTheme Dracula.xccolortheme
	defaults write com.apple.dt.Xcode DVTTextShowFoldingSidebar 1
	defaults write com.apple.dt.Xcode DVTTextEditorTrimWhitespaceOnlyLines 1
	# Copilot
	cd ~/Downloads
	curl -O https://github.com/github/CopilotForXcode/releases/latest/download/GitHubCopilotForXcode.dmg
	cd

