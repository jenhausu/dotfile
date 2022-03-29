function github -d "Open current repository github page."
	set url (git config --get remote.origin.url |
				sed -E 's/:([^\/])/\/\1/g' |
				sed -e 's/ssh\/\/\///g' |
				sed -e 's/git@/https:\/\//g' |
				sed 's/....$//')
	open -a Safari $url
end
