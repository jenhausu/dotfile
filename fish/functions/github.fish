function github -d "Open current repository github page."
	set url (git config --get remote.origin.url |
				sed -E 's/:([^\/])/\/\1/g' |
				sed -e 's/ssh\/\/\///g' |
				sed -e 's/git@/https:\/\//g' |
				sed 's/....$//')
	if set -q argv[1] && test $argv[1] = action
		set url $url/actions
	else if set -q argv[1] && test $argv[1] = pr
		set url $url/pulls
	end
	open -a Safari $url
end
