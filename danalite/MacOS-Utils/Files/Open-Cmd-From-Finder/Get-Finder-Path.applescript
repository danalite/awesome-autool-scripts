tell application "Finder"
    if exists Finder window 1 then
        set currentDir to target of Finder window 1 as alias
    else
        set currentDir to desktop as alias
    end if
    do shell script "echo " & POSIX path of currentDir
end tell