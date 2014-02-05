property pVer : "0.5"-- CONVERT FROM TASKPAPER DATE TIME STRINGS TO APPLESCRIPT,set blnTime to trueset strTaskPaperDate to AS2TPDateTime(current date, blnTime)-- AND CONVERT BACK FROM AN APPLESCRIPT DATE TO A TASKPAPER DATE (TIME) STRINGset dteNow to TP2ASDateTime(strTaskPaperDate){dteNow, strTaskPaperDate}-- Convert a TASKPAPER Date to an APPLESCRIPT date-- (avoiding assumptions about locale-dependent date string formats)on TP2ASDateTime(strDate)	tell (current date)		set its year to (text 1 thru 4 of strDate)		set its day to 1 -- (temporarily, lest a short month lacks some days)		set its month to (text 6 thru 7 of strDate)		set its day to (text 9 thru 10 of strDate)		set its hours to 0		set its minutes to 0		set its seconds to 0				if length of strDate > 11 then			set {dlm, my text item delimiters} to {my text item delimiters, ":"}			set lstTime to text items of (text 12 thru -1 of strDate)			set my text item delimiters to dlm						set lngParts to length of lstTime			if lngParts > 0 then				set its hours to item 1 of lstTime				if lngParts > 1 then					set its minutes to item 2 of lstTime					if lngParts > 2 then set its seconds to item 3 of lstTime				end if			end if		end if				return it	end tellend TP2ASDateTime-- Convert an APPLESCRIPT date to a TASKPAPER Date-- (including or dropping the time)on AS2TPDateTime(dteAS, blnTime)	tell dteAS		set lstDate to {its year, my PadNum((its month as integer), 2), my PadNum((its day), 2)}		set {dlm, my text item delimiters} to {my text item delimiters, "-"}		set strDate to lstDate as string				set my text item delimiters to ":"		if blnTime then			set lstTime to {its hours, its minutes}			set strDate to strDate & space & (lstTime as string)		end if		set my text item delimiters to dlm	end tell	return strDateend AS2TPDateTime-- Add leading zeros to get specified widthon PadNum(lngNum, lngDigits)	set strNum to lngNum as string	set lngGap to (lngDigits - (length of strNum))	repeat while lngGap > 0		set strNum to "0" & strNum		set lngGap to lngGap - 1	end repeat	return strNumend PadNumon UnixEpoch()	-- Using date "1/1/1970" is too parochial, consider:	-- date "יום חמישי 1 ינואר 1970 00:00:00"	-- and it would actually fail in some locales e.g. China,	-- where a growing proportion of macs are bought ...	-- http://www.nytimes.com/2011/07/25/technology/apple-sales-in-china-zoom-ahead-of-competitors.html	-- date "1970年1月1日星期四 上午12:00:00"		tell (current date)		set {its year, its day, its month, its time} to {1970, 1, 1, 0}		return it	end tellend UnixEpoch