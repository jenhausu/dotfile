# abbr
abbr gl "git log"
abbr glg "git log --oneline --graph --decorate --date=relative"
abbr gd "git diff"
abbr gdc "git diff --cached"
abbr gbd "git branch -D"

abbr b "bundle exec"
abbr fast "bundle exec fastlane"

abbr openv "open -a Visual\ Studio\ Code"

if not functions -q fisher
    set -q XDG_CONFIG_HOME; or set XDG_CONFIG_HOME ~/.config
    curl https://git.io/fisher --create-dirs -sLo $XDG_CONFIG_HOME/fish/functions/fisher.fish
    fish -c fisher
end

starship init fish | source

set LANG en_US.UTF-8

fish_vi_key_bindings
