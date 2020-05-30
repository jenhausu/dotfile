function gitclone
    git clone $argv
    set folder (basename $argv .git)
    cd $folder
    
    xc
end
