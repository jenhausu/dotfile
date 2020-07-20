function git_branch_delete_merged
	echo git fetch...
	git fetch -p

	# get remote merged branch
	set remote_merged_branchs (git branch --remote --merged origin/master | grep -v 'master' | cut -b 10- )

	# if current branch is at any remote merged branch, checkout to master
	set branch_current (git branch | sed -n -e 's/^\* \(.*\)/\1/p')
	if contains $branch_current $remote_merged_branchs
		git checkout master
	end

	echo 'remove remote merged branch'
	git branch --remote --merged origin/master | grep -v 'master' | cut -b 10- | xargs git push --delete origin

	echo "remove local branch is merged remotely"
	echo $remote_merged_branchs | xargs git branch -D

	echo 'remove local merged branch'
	git branch --merged | egrep -v "(^\*|master|develop)" | xargs git branch -d
end
