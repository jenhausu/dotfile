# abbr
abbr gs "git status"
abbr gl "git log"
abbr glg "git log --oneline --graph --decorate --date=relative"
abbr gd "git diff"
abbr gdc "git diff --cached"
abbr gbd "git branch -D"
abbr gpm "git pull origin master"

abbr be "bundle exec"
abbr fastl "bundle exec fastlane"
abbr cdpro "cd ~/Library/MobileDevice/Provisioning\ Profiles/"

abbr c "clear"

abbr openb "open -a Brackets"
abbr opena "open -a Atom"

abbr github "open https://github.com/OsenseTech/brother-ios"
abbr go google

if not functions -q fisher
    set -q XDG_CONFIG_HOME; or set XDG_CONFIG_HOME ~/.config
    curl https://git.io/fisher --create-dirs -sLo $XDG_CONFIG_HOME/fish/functions/fisher.fish
    fish -c fisher
end

thefuck --alias | source
starship init fish | source

set LANG en_US.UTF-8

fish_vi_key_bindings
