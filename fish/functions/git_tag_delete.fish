function git_tag_delete -d "Delete tag at both local and remote."
    git tag -d $argv
    git push --delete origin $argv
end
