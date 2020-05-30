function gitmerge -w "git merge" -d "Merge branch with no fast forward."
    git merge --no-ff $argv
end
