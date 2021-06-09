loop {
	IfWinActive, Path of Exile
	{
	Keywait, LButton, t.8
	;time to wait how long left mouse button was pressed - .8 = 0.8 seconds
	;this fits for me, as long as holding left mouse if my main walking skill
 
	if (ErrorLevel=1) { 

	SendInput, q
	;press button 4, where my quicksilver is at

	Sleep 4000
	;wait 4 seconds until started again
	;if you want another quicksilver flask to be used after 4 seconds, just add another send and sleep afterwards
	;SendInput 3
	;Sleep 4000
	}
}
}



	IfWinActive, Path of Exile
	{
		~LButton::
		if GetKeyState("LButton") {
			Keywait, LButton, t.7
			if (ErrorLevel=0) {
				Sleep 7000
				SendInput, q
				Sleep 10
				SendInput, r
				Sleep 10
				SendInput, 3
				Sleep 10
				SendInput, 4
				
	;			SetTimer, Bq, 3500
	;			SetTimer, Br, 7567
	;			SetTimer, B3, 5456
	;			SetTimer, B4, 4987
			} ;else {
;			SetTimer, Bq, off
;			SetTimer, Br, off
;			SetTimer, B3, off
;			SetTimer, B4, off
		;}
		}
		
		;if ()
		
;		bq:
;			SendInput, q
;		Return
;		br:
;			SendInput, r
;		Return
;		b3:
;			SendInput, 3
;		Return
;		b4:
;			SendInput, 4
;		Return
	}
	;time to wait how long left mouse button was pressed - .8 = 0.8 seconds
	;this fits for me, as long as holding left mouse if my main walking skill
	;press button 4, where my quicksilver is at
	;wait 4 seconds until started again
	;if you want another quicksilver flask to be used after 4 seconds, just add another send and sleep afterwards
	;SendInput 3
	;Sleep 4000
#If