function git_branch_backup
    set current_branch (git branch --show-current)
    git checkout -b "$current_branch-backup"
end
