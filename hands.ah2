#HotIf WinActive("Path of Exile")
#SingleInstance force
#Warn
Persistent
#MaxThreadsPerHotkey 2
#MaxThreadsBuffer 1
InstallMouseHook true
SetTitleMatchMode 3
SetMouseDelay -1
SendMode "Input"
CoordMode "Mouse", "Client"
SetWorkingDir A_ScriptDir
Thread "interrupt", 0
MyIcon := "hands.ico"
If FileExist(MyIcon) {
	TraySetIcon(MyIcon)
}

; Global variables
Global Overlay 		:= ""
Global Speed		:= 1
Global LClick		:= 0
Global GuiX			:= 565
Global GuiY			:= 1030
Global APotOnOff	:= 0
Global AQuitOnOff	:= 0
Global AFLaskOnOff	:= 0
Global OnShow		:= 0
Global DebugOnOff	:= 0
Global ForceLogout	:= 1

Global IconMatchX	:= ""
Global IconMatchY	:= ""

Global TimeKeyQ		:= 50 + 0
Global TimeKeyW		:= 50 + 0
Global TimeKeyE		:= 50 + 12170
Global TimeKeyR		:= 50 + 68220
Global TimeKeyT		:= 50 + 18650

Global TimeKey1		:= 50 + 0
Global TimeKey2		:= 50 + 6000
Global TimeKey3		:= 50 + 8500
Global TimeKey4		:= 50 + 6000
Global TimeKey5		:= 50 + 3400

; Reading or creating config file
if FileExist("hands.ini"){
	Speed  := IniRead("hands.ini", "General", "Speed")
	LClick := IniRead("hands.ini", "General", "LClick")
} else {
	IniWrite  Speed, "hands.ini", "General", "Speed"
	IniWrite LClick, "hands.ini", "General", "LClick"
}

; Functions
RandomSleep(min,max){
	r := Random(min, max)
	r := floor(r/Speed)
	Sleep r
	return
}

; Gui information refresh time
SetTimer GuiStatus, 50

; Controls
^1:: {

}

^2:: { ;Auto-Pot
	Global
	if APotOnOff = 0 {
		Overlay['T2'].SetFont("c004900")
		Overlay['T2'].Value := "On "
		APotOnOff := 1
	} else {
		Overlay['T2'].SetFont("cB9905F")
		Overlay['T2'].Value := "Off"
		APotOnOff := 0
	}
}

^3:: { ;Auto-Quit
	Global
	if AQuitOnOff = 0 {
		Overlay['T3'].SetFont("c004900")
		Overlay['T3'].Value := "On "
		AQuitOnOff := 1
	} else {
		Overlay['T3'].SetFont("cB9905F")
		Overlay['T3'].Value := "Off"
		AQuitOnOff := 0
	}
}

^4:: { ;Auto-Flask
	Global
	if AFLaskOnOff = 0 {
		Overlay['T4'].SetFont("c004900")
		Overlay['T4'].Value := "On "
		AFLaskOnOff := 1
	} else {
		Overlay['T4'].SetFont("cB9905F")
		Overlay['T4'].Value := "Off"
		AFLaskOnOff := 0
	}
}

; Gui Overlay
GuiStatus() {
	Global
	if WinActive("Path of Exile") and (OnShow = 0) and (ImageSearch(&IconMatchX, &IconMatchY, 7, 874, 26, 893, "*40 imgs\chaticon.png")) {
		Overlay := Gui()
		Overlay.Opt("+LastFound")
		Overlay.SetFont("cE7B477 s10 w700", "Trebuchet MS")
		Overlay.Add("Text", "BackgroundTrans vT1", "[ HP: 100 ]")
		Overlay.Add("Text", "x+30 BackgroundTrans", "[ Auto-Pot: ")
		if APotOnOff = 0 {
			Overlay.Add("Text", "x+0.1 BackgroundTrans vT2", "Off")
			Overlay['T2'].SetFont("cB9905F")
		} else {
			Overlay.Add("Text", "x+0.1 BackgroundTrans vT2", "On ")
			Overlay['T2'].SetFont("c004900")
		}
		Overlay.Add("Text", "x+0.1 BackgroundTrans", " ]        [ Auto-Quit: ")
		if AQuitOnOff = 0 {
			Overlay.Add("Text", "x+0.1 BackgroundTrans vT3", "Off")
			Overlay['T3'].SetFont("cB9905F")
		} else {
			Overlay.Add("Text", "x+0.1 BackgroundTrans vT3", "On ")
			Overlay['T3'].SetFont("c004900")
		}
		Overlay.Add("Text", "x+0.1 BackgroundTrans", " ]        [ Auto-Flask: ")
		if AFLaskOnOff = 0 {
			Overlay.Add("Text", "x+0.1 BackgroundTrans vT4", "Off")
			Overlay['T4'].SetFont("cB9905F")
		} else {
			Overlay.Add("Text", "x+0.1 BackgroundTrans vT4", "On ")
			Overlay['T4'].SetFont("c004900")
		}
		Overlay.Add("Text", "x+0.1 BackgroundTrans", " ]")
		Overlay.BackColor := "0X130F13"
		WinsetTranscolor "0X130F13"
		Overlay.Opt("+AlwaysOnTop -Border -Caption -Sysmenu +ToolWindow +E0x20")
		Overlay.Show("x" . GuiX . " y" . GuiY . " NA")
		OnShow := 1
	}
	if (!WinActive("Path of Exile") and OnShow = 1) or (!ImageSearch(&IconMatchX, &IconMatchY, 7, 874, 26, 893, "*40 imgs\chaticon.png") and OnShow = 1) {
		Overlay.Destroy()
		OnShow := 0
	}
}

if DebugOnOff = 1 {
	Global DebugGui := Gui()
	DebugGui.Add("Edit"		,"w320 r3 ReadOnly vDebugView","")
	DebugGui.Add("Edit"		,"w40         vX","X")
	DebugGui.Add("Text"		,"    x56 y62   ","X")
	DebugGui.Add("Edit"		,"w40 x70 y58 vY","Y")
	DebugGui.Add("Text"		,"w130 r2    x120 y55   ","Clique para mover o cursor para as coordenadas")
	DebugGui.Add("Button"	,"w80 x251 y58   ","&Mover").OnEvent("Click", MoveMouse)
	DebugGui.Show("NoActivate")
	DebugGui['DebugView'].Value := Keywait
}
~F3:: {
	MoveMouse
}

MoveMouse(*) {
	Global
	Sleep 1000
	MouseMove 10, 875, 0, ""
	Sleep 1000
	MouseMove 22, 899, 0, ""
	sleep 1000
}

Logout() {
	Critical "On"
	BlockInput "On"
	if ForceLogout = 1 {
		Run "*RunAs cports.exe /close * * * * PathOfExile_x64.exe"
		Run "*RunAs cports.exe /close * * * * PathOfExile_x64Steam.exe"
		Run "*RunAs cports.exe /close * * * * PathOfExileSteam.exe"
		Run "*RunAs cports.exe /close * * * * PathOfExile.exe"
		Send "{Enter}/exit{Enter}"		
	} else {
		Send "{Enter}/exit{Enter}"
	}
	RandomSleep(20,50)
	BlockInput "Off"
	return
}

if ImageSearch(&IconMatchX, &IconMatchY, 7, 874, 26, 893, "*40 imgs\chaticon.png") {
	;Send "{Enter}ok" IconMatchX "x" IconMatchY
} else {
	;Send "{Enter}no"
}


if WinActive("Path of Exile") {
	~LButton:: {
		if GetKeyState("LButton", "P") and AFLaskOnOff = 1 {
			if !Keywait("LButton", "T.9") and LClick = 0 {
				RandomSleep(1,20)
				SendInput "e"
				RandomSleep(1,20)
				SendInput "r"
				RandomSleep(1,20)
				SendInput "t"
				RandomSleep(1,20)
				SendInput "2"
				RandomSleep(1,20)
				SendInput "3"
				RandomSleep(1,20)
				SendInput "4"
				RandomSleep(1,20)
				SendInput "5"
				SetTimer Be, TimeKeyE
				SetTimer Br, TimeKeyR
				SetTimer Bt, TimeKeyT
				SetTimer B2, TimeKey2
				SetTimer B3, TimeKey3
				SetTimer B4, TimeKey4
				SetTimer B5, TimeKey5
				Global LClick:=1
			}
		}
	}
}

Bmb() {
	if GetKeyState("LButton") {
		SendInput "{MButton}"
	} else {
		Global LClick:=0
		SetTimer Bmb, 0
	}
}

Be() {
	if GetKeyState("LButton") {
		SendInput "e"
	} else {
		Global LClick:=0
		SetTimer Be, 0
	}
}

Br() {
	if GetKeyState("LButton") {
		SendInput "r"
	} else {
		Global LClick:=0
		SetTimer Br, 0
	}
}

Bt() {
	if GetKeyState("LButton") {
		SendInput "t"
	} else {
		Global LClick:=0
		SetTimer Bt, 0
	}
}

B2() {
	if GetKeyState("LButton") {
		SendInput "2"
	} else {
		Global LClick:=0
		SetTimer B2, 0
	}
}

B3() {
	if GetKeyState("LButton") {
		SendInput "3"
	} else {
		Global LClick:=0
		SetTimer B3, 0
	}
}

B4() {
	if GetKeyState("LButton") {
		SendInput "4"
	} else {
		Global LClick:=0
		SetTimer B4, 0
	}
}

B5() {
	if GetKeyState("LButton"){
		SendInput "5"
	} else {
		Global LClick:=0
		SetTimer B5, 0
	}
}

~w:: {
	RandomSleep(1,10)
	SendInput "1"
}

~q:: {
	RandomSleep(90,99)
	SendInput "{MButton}"
}