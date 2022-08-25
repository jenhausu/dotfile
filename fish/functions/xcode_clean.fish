function xcode_clean
	set deviceSupport_ios ~/Library/Developer/Xcode/iOS\ DeviceSupport/
	set deviceSupport_wachOS ~/Library/Developer/Xcode/watchOS\ DeviceSupport/
	set document ~/Library/Developer/Shared/Documentation/
	set downloads ~/Library/Caches/com.apple.dt.Xcode/Downloads/
	set simulator ~/Library/Developer/CoreSimulator/

	if count $argv > /dev/null
		du -sh $deviceSupport_ios
		du -sh $deviceSupport_watchOS
		du -sh $document
		du -sh $downloads
		du -sh $simulator
	else if test $argv[1] = remove
		rm $deviceSupport_ios
		rm $deviceSupport_watchOS
	end
end
