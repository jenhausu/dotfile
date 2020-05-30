function git_push -w "git push origin" -d "push current branch"
    set branch_current (git branch | sed -n -e "s/^\* \(.*\)/\1/p")
    if [ $branch_current != "master" ]
        if count $argv > /dev/null
            if test $argv[1] != "-f"
                git_pull
            end
        end
    end

    echo git push...
    git push origin $branch_current $argv
end
