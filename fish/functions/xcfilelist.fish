function xcfilelist
	if test $argv[1] = install
		echo "\$(SRCROOT)/Carthage/Build/iOS/$argv[2].framework" >> input.xcfilelist
		echo "\$(BUILT_PRODUCTS_DIR)/\$(FRAMEWORKS_FOLDER_PATH)/$argv[2].framework" >> output.xcfilelist
	else if test $argv[1] = uninstall
		sed -i "" "/$argv[2]/d" ./input.xcfilelist
		sed -i "" "/$argv[2]/d" ./output.xcfilelist
	end
end
