function git_switchlanguage -d "Switch git language."
	if test $argv = US
		set LANG en_US.UTF-8
	else if test $argv = TW
		set LANG zh_TW.UTF-8
	end
end
