# install fish
brew install fish

# install oh-my-fish
curl https://raw.githubusercontent.com/oh-my-fish/oh-my-fish/master/bin/install | fish
omf install xcode
omf install z
omf install bang-bang
omf install https://github.com/jhillyerd/plugin-git
brew install jq
omf install weather

# fisher
curl https://git.io/fisher --create-dirs -sLo ~/.config/fish/functions/fisher.fish
brew install terminal-notifier
fisher install franciscolourenco/done
fisher install markcial/upto
fisher install acomagu/fish-async-prompt
fisher install andreiborisov/sponge # make command history clear
