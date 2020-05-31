function sync_pull
	# sync fish config
	cp ~/Documents/repository/dotfile/fish/config.fish ~/.config/fish/config.fish

	# sync fish function
	cp ~/Documents/repository/dotfile/fish/functions/* ~/.config/fish/functions/

	# sync git config
	cp ~/Documents/repository/dotfile/.gitconfig ~/.gitconfig
end
