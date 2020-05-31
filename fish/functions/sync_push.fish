function sync_push
	# sync fish config
	cp ~/.config/fish/config.fish ~/Documents/repository/dotfile/fish/config.fish

	# sync fish function
	cp ~/.config/fish/functions/*.fish ~/Documents/repository/dotfile/fish/functions/

	# sync git config
	cp ~/.gitconfig ~/Documents/repository/dotfile/.gitconfig

	# vimrc
	cp ~/.vimrc ~/Documents/repository/dotfile/
end
