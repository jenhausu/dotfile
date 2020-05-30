function git_branch_current_name
    set current_branch (git branch | sed -n -e "s/^\* \(.*\)/\1/p")
    echo $current_branch | pbcopy
    echo $current_branch
end
