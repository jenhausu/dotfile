function gitcheck -w "git checkout" -d "pod install after git check"
    git checkout $argv
    
    set d (diff "Podfile.lock" "Pods/Manifest.lock")
    if test "$d" != ""
        echo "pod install..."
        bundle exec pod install
    end
end
