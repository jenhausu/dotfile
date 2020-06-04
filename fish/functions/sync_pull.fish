function sync_pull
	# sync fish config
	cp ~/Documents/repository/dotfile/fish/config.fish ~/.config/fish/config.fish

	# sync fish function
	cp ~/Documents/repository/dotfile/fish/functions/* ~/.config/fish/functions/

	# sync git config
	cp ~/Documents/repository/dotfile/.gitconfig ~/.gitconfig

	# sync vimrc
	cp ~/Documents/repository/dotfile/.vimrc ~/.vimrc

	# hyper
	cp ~/Documents/repository/dotfile/.hyper.js ~/.hyper.js

	# starship
	cp ~/Documents/repository/dotfile/starship.toml ~/.config/starship.toml
end
