#IfWinActive Path of Exile
#SingleInstance force
#NoEnv
#Warn
#Persistent
#MaxThreadsPerHotkey 2
#InstallMouseHook

SetTitleMatchMode 3
SetMouseDelay, -1
SendMode Input
CoordMode, Mouse, Client
SetWorkingDir %A_ScriptDir%
Thread, interrupt, 0

I_Icon = hands.ico
IfExist, %I_Icon%
	Menu, Tray, Icon, %I_Icon%

; Global variables
global Speed=1
global LClick=0
global GuiX=-5
global GuiY=90
global OnOff=0


if FileExist("hands.ini"){
	IniRead, Speed, hands.ini, General, Speed
	IniRead, LClick, hands.ini, General, LClick
} else {
	IniWrite, %Speed%, hands.ini, General, Speed
	IniWrite, %LClick%, hands.ini, General, LClick
}


; Functions
RandomSleep(min,max){
	Random, r, %min%, %max%
	r:=floor(r/Speed)
	Sleep %r%
	return
}

~F3::
	if (OnOff=0) {
		OnOff=1
	} else {
		OnOff=0
	}
Return


if WinActive( "Path of Exile" ) {

	~LButton::
		if GetKeyState("LButton") and OnOff=1 {
			Keywait, LButton, t.8
			if (ErrorLevel=1 and LClick=0) {
				;RandomSleep(1,20)
				;SendInput, {MButton}
				RandomSleep(1,20)
				SendInput, e
				RandomSleep(1,20)
				SendInput, r
				RandomSleep(1,20)
				SendInput, t
				RandomSleep(1,20)
				SendInput, 2
				RandomSleep(1,20)
				SendInput, 3
				RandomSleep(1,20)
				SendInput, 4
				RandomSleep(1,20)
				SendInput, 5
				;SetTimer, Bmb, 7650
				SetTimer, Be, 3130
				SetTimer, Br, 27700
				SetTimer, Bt, 10430
				SetTimer, B2, 5050
				SetTimer, B3, 5550
				SetTimer, B4, 3850
				SetTimer, B5, 6050
				LClick=1
			}
		}
	Return

	Bmb:
		if GetKeyState("LButton") {
			SendInput, {MButton}
		} else {
			LClick=0
			SetTimer, Bmb, Delete
		}
	Return
	Be:
		if GetKeyState("LButton") {
			SendInput, e
		} else {
			LClick=0
			SetTimer, Be, Delete
		}
	Return
	Br:
		if GetKeyState("LButton") {
			SendInput, r
		} else {
			LClick=0
			SetTimer, Br, Delete
		}
	Return
	Bt:
		if GetKeyState("LButton") {
			SendInput, t
		} else {
			LClick=0
			SetTimer, Bt, Delete
		}
	Return
	B2:
		if GetKeyState("LButton") {
			SendInput, 2
		} else {
			LClick=0
			SetTimer, B2, Delete
		}
	Return
	B3:
		if GetKeyState("LButton") {
			SendInput, 3
		} else {
			LClick=0
			SetTimer, B3, Delete
		}
	Return
	B4:
		if GetKeyState("LButton") {
			SendInput, 4
		} else {
			LClick=0
			SetTimer, B4, Delete
		}
	Return
	B5:
		if GetKeyState("LButton"){
			SendInput, 5
		} else {
			LClick=0
			SetTimer, B5, Delete
		}
	Return
	~w::
		RandomSleep(1,10)
		SendInput, 1
		;RandomSleep(10,20)
		;SendInput, {MButton}
	Return
}