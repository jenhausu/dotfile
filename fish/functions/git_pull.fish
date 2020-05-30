function git_pull -w "git pull origin" -d "git pull at current git branch"
    git stash
    set branch (git branch | sed -n -e "s/^\* \(.*\)/\1/p")
    echo git pull...
    git pull origin $branch --rebase
    git stash pop
end
