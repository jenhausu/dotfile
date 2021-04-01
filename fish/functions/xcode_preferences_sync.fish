function xcode_preferences_sync
	if test $argv[1] = "push"
		cp -R ~/Library/Developer/Xcode/UserData/CodeSnippets ~/Documents/repository/XcodePreferences/
		cp -R ~/Library/Developer/Xcode/UserData/KeyBindings ~/Documents/repository/XcodePreferences/
		cp ~/Library/Preferences/com.apple.dt.Xcode.plist ~/Documents/repository/XcodePreferences/
		cp -R ~/Library/Developer/Xcode/UserData/FontAndColorThemes ~/Documents/repository/XcodePreferences/
	end

	if test $argv[1] = "pull"
		cp -R ~/Documents/repository/XcodePreferences/ ~/Library/Developer/Xcode/UserData/
		cp ~/Documents/repository/XcodePreferences/com.apple.dt.Xcode.plist ~/Library/Preferences/
	end
end
