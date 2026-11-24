tell application "Safari"
	activate
	repeat 20 times
		try
			if (count of documents) is 0 then make new document
			set bounds of front window to {0, 31, 2176, 1080}
			exit repeat
		on error
			delay 0.25
		end try
	end repeat
end tell
