-- https://discussions.apple.com/thread/8263239
tell application "System Events"
    set ProcNm_ to name of every application process whose visible is true
end tell

repeat with i_ from 1 to count items of ProcNm_
    set TarProc_ to item i_ of ProcNm_
    try
        tell application TarProc_ to quit  -- you can add "without saving" if you need no action!
    end try
end repeat

tell application "System Events"
    shut down
end tell