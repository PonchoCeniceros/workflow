set js to "ObjC.import('AppKit');var s=$.NSScreen.screens;var m=s.objectAtIndex(0).frame;var d=s.objectAtIndex(s.count>1?1:0).visibleFrame;[d.origin.x,m.size.height-(d.origin.y+d.size.height),d.size.width,d.size.height].join(' ')"
set AppleScript's text item delimiters to " "
set area to text items of (do shell script "osascript -l JavaScript -e " & quoted form of js)
set AppleScript's text item delimiters to ""
set x to (item 1 of area) as number
set arriba to (item 2 of area) as number
set ancho to (item 3 of area) as number
set alto to (item 4 of area) as number

tell application id "md.obsidian"
	reopen
	activate
end tell

tell application "System Events"
	tell process "Obsidian"
		repeat 40 times
			try
				set position of window 1 to {x, arriba}
				set size of window 1 to {ancho, alto}
				exit repeat
			on error
				delay 0.25
			end try
		end repeat
	end tell
end tell
