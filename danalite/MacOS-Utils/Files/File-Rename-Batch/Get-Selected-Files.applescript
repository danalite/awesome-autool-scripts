tell application "Finder"
	set selected_items to selection
	set selected_files to {}
	repeat with item_ref in selected_items
		set end of selected_files to POSIX path of (item_ref as alias)
	end repeat
	return selected_files
end tell