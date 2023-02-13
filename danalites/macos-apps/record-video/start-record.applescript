-- https://apple.stackexchange.com/a/374114
--  # Setup to do a screen recording.
tell application "QuickTime Player" to new screen recording

--  # Start the screen recording.
tell application "System Events" to tell process "Screen Shot"
    repeat until exists button "Record" of its front window
        delay 0.1
    end repeat
    click button "Record" of its front window
end tell
