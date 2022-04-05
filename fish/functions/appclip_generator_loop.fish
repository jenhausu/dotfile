function appclip_generator_loop
	set url_prefix $argv[1]
	set startId $argv[2]
	set endId $argv[3]

	if test url_prefix = nil
		set url_prefix "https://appclip.osensetech.com"
	end

	for id in (seq $startId $endId)
		set idDecimal (echo $id | awk '{printf("%d",$0);}' )
		set url "$url_prefix/contact?id=$idDecimal"
		if test $id = $startId
			echo $url
		end

		AppClipCodeGenerator generate --url $url --index 15 --output ~/Downloads/AppClipCode/$id.svg
	end
end
