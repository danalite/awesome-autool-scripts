property lowBattery : 25
-- https://apple.stackexchange.com/a/117630

on idle
    set battStatus to do shell script "pmset -g ps"
    if battStatus contains "InternalBattery" then
        set {TID, text item delimiters} to {text item delimiters, ";"}
        set battStatus to text items of battStatus
        set text item delimiters to space
        set battStatus to text 1 thru -2 of last text item of item 1 of battStatus as integer
        set text item delimiters to TID

        -- Shutdown if battery is less than 25%
        if battStatus < lowBattery then 
             tell application "Finder"
                shut down
            end tell
        end if
        
    end if
    return 60
end idle