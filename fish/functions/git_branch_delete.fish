function git_branch_delete -w "git branch -D" -d "hard delete branch on lodal and remote"
    # delete branch on local
	set branch_current (git branch | sed -n -e 's/^\* \(.*\)/\1/p')
    if [ "$branch_current" = "$argv" ]
        git checkout master
    end
    git branch -D $argv

	# delete branch on remote
    set branch_remote (git branch --remote | grep $argv | cut -b 10- )
    if test -n "$branch_remote"
        git push origin --delete $argv
    end
end
