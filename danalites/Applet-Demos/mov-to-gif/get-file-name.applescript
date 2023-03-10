-- https://forum.keyboardmaestro.com/t/getting-the-path-of-currently-selected-file-in-finder/1507/2

tell application "Finder"
  set finderSelList to selection as alias list
end tell

if finderSelList ­ {} then
  repeat with i in finderSelList
    set contents of i to POSIX path of (contents of i)
  end repeat
  
  set AppleScript's text item delimiters to linefeed
  finderSelList as text
end if