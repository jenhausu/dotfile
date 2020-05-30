function git_rebase_continue -d "git add . & git rebase --continue"
    git add .
    git rebase --continue
    git status
end
