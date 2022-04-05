function appclip_generator
	set url_prefix $argv[1]
	set id $argv[2]
	set url "$url_prefix?id=$id"

	echo $url

	AppClipCodeGenerator generate --url $url --index 15 --output ~/Downloads/AppClipCode/$id.svg
end
