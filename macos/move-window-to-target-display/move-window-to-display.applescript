-- https://apple.stackexchange.com/a/136326
-- Window Moving Script between multiple monitors for Apple Mac OS X 10.x
-- (something I've been doing with UltraMon for quite a while)
--  inspired by:
--     http://www.tidbits.com/webx?14@@.3c7b1ae3/5
--     http://macscripter.net/viewtopic.php?id=24511
-- and http://daringfireball.net/2006/12/display_size_applescript_the_lazy_way
-- thanx for the input ... I was looking for a solution of this quite a while
-- best to be used with a custom trigger in Quicksilver where this script is assigned to a
-- keyboard short cut (I use ALT Cursor-Right) 
-- you might want to put Quicksilver into your Autostart Objects
-- 2009-09-14 Wolfgang Fahl

--
-- get the front Window
-- 
on getFrontWindow1()
    tell application "System Events"
        set theFrontWindow to first window of (first process whose frontmost is true)
        -- set theFrontWindow to the front window
        set windowname to name of theFrontWindow as string
        say "Moving" & windowname
        -- display dialog "front most windows is " & name of  theFrontWindow buttons ("Cool") giving up after 3 default button 1
        return theFrontWindow
    end tell
end getFrontWindow1
--
-- get the front Window
-- 
on getFrontWindow()
    tell application "System Events"
        repeat with theapp in (every application process whose visible is true and frontmost is true)
            repeat with ew in (every window of theapp)
                return ew
            end repeat
        end repeat
    end tell
end getFrontWindow
--
-- list all windows
--
on listWindows()
    tell application "System Events"
        repeat with theapp in (every application process whose visible is true and frontmost is true)
            repeat with ew in (every window of theapp)
                set windowname to name of ew as string
                say windowname
            end repeat
        end repeat
    end tell
end listWindows

--
-- message dialog
--
on show(aMessage)
    -- display a dialog with a message
    display dialog aMessage buttons {"Ok"} default button "Ok"
end show

--
-- get the screen information
--
on getScreenInfo(theIndex)
    -- get the Screen Information from the windowserver defaults
    -- we are using awk to go to the DisplaySets sections and assume that Active = ... is
    -- at the start of each section
    -- we'll find OriginX= ...,OriginY= ..., Width = ... and Height= ... entries
    -- and return all of them a a list like
    -- 0 0     1920 1200
    -- 0 1920  1650 1050
    set screenInfo to do shell script "defaults read /Library/Preferences/com.apple.windowserver | awk '
        BEGIN { FS=\"=\" }
        /Active/  { screens++ }
        { gsub(\";\",\"\",$2) }
        /^ *OriginX/ { ox[screens] = $2 }
        /^ *OriginY/ { oy[screens] = $2 }
        /^ *Width/   { w[screens]  = $2 }
        /^ *Height/  { h[screens]  = $2 }
        END       {
                for (si=1;si<=screens;si++) {
                    print ox[si],oy[si],w[si],h[si]
                    }
            }'"
    set theInfo to paragraph theIndex of screenInfo
    return {word 1 of theInfo, word 2 of theInfo, word 3 of theInfo, word 4 of theInfo}
end getScreenInfo

--
-- move the front window to another monitor
--
set targetDisplay to 1
set isMoving to true

tell application "System Events"
    -- get the OffsetX,OffsetY,Width and Height information for the screens
    -- here we assume that two screens are present (without checking this ...)
    -- first screen info
    set theScreen1 to getScreenInfo(1) of me

    -- second screen info
    set theScreen2 to getScreenInfo(2) of me

    -- for the functionality of this script we are happy with the resolution info for the time being
    set startX to item 1 of theScreen1
    set startY to item 2 of theScreen1
    set resolutionX to item 3 of theScreen1
    set resolutionY to item 4 of theScreen1

    set startX2 to item 1 of theScreen2
    set startY2 to item 2 of theScreen2
    set resolutionX2 to item 3 of theScreen2
    set resolutionY2 to item 4 of theScreen2

    -- make some nois to let everybody know we have receive the command
    -- beep

    -- 1st, determine current X & Y Positions of the current front window
    set theWindow to getFrontWindow() of me
    set thePosition to position of theWindow

    -- uncomment this if you'd like to debug
    -- display alert name of theWindow & ": " & ((first item of thePosition) as string) & ", " & ((second item of thePosition) as string) & " screen1:" & (startX as string) & "," & (startY as string) & "-" & (resolutionX as string) & "," & (resolutionY as string) & " screen2:" & (startX2 as string) & "," & (startY2 as string) & "-" & (resolutionX2 as string) & "," & (resolutionY2 as string)
    set currXPos to (first item of thePosition)
    set currYPos to (second item of thePosition)

    -- are we on the first monitor?
    if currXPos < resolutionX / 2 then
        -- move right
        set newX to currXPos + resolutionX
        set newY to currYPos - startY2
        if targetDisplay is 1 then
            set isMoving to false
        end if
    else
        -- move left
        set newX to currXPos - resolutionX
        if newX < startX then
            set newX to startX
        end if
        set newY to currYPos + startY2
        if targetDisplay is 2 then
            set isMoving to false
        end if
    end if

    -- Now we move the window moveX pixels to the right (or left if negative)
    if isMoving then
        set position of theWindow to {(newX), (newY)}
    end if

end tell