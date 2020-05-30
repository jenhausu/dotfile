function git_log_current -d "git log current branch"
	git log --oneline master..
end
