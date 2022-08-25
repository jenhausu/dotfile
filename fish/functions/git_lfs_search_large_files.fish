function git_lfs_large_files
	find . -not \( -path "./.git/*" -prune \) \
		-not \( -path "./vendor/bundle/*" -prune \) \
		   -not \( -path "*/bundler/*" -prune \) \
		   -not \( -path "./Pods/*" -prune \) \
		   -not \( -path "./Carthage/*" -prune \) \
		   -not \( -path "./Packages/*" -prune \) \
		   -not -name "*.ipa" \
		   -not -name "*.zip" \
		   -type f -size +10MB | xargs git lfs track
end
