#include <Array.au3>
#include <GuiComboBox.au3>
#include <GUIConstantsEx.au3>

; Script Start - Add your code below here
Global $usbIDs = ""
If not FileExists("usb.ids") Then InetGet("http://www.linux-usb.org/usb.ids", "usb.ids")
$usbIDs = FileRead("usb.ids")
If not FileExists("hidtrace.exe") Then InetGet("http://www.virtualdj.com/download/hidtrace.exe", "hidtrace.exe")
If not FileExists("hidtrace.exe") Then
    MsgBox(0, "ERROR", "This program acts as a wrapper for and requires hidtrace.exe to work."&@CRLF&"Attempts to automaticly download it has failed. Please download hidtrace.exe from"&@CRLF&"http://www.virtualdj.com/download/hidtrace.exe"&@CRLF&" and place it in the same folder as this program and run again."&@CRLF&@CRLF&"(The link has been copied to clipboard)")
    Exit
EndIf

#include <ButtonConstants.au3>
#include <ComboConstants.au3>
#include <EditConstants.au3>
#include <StaticConstants.au3>
#include <WindowsConstants.au3>

OnAutoItExitRegister("onExit")

#Region ### START Koda GUI section ### Form=
$Form1 = GUICreate("Form1", 706, 440)

$Label1 = GUICtrlCreateLabel("A", 592, 144, 11, 17)
$Label3 = GUICtrlCreateLabel("X", 592, 96, 11, 17)
$Label4 = GUICtrlCreateLabel("Y", 640, 120, 11, 17)
$Label5 = GUICtrlCreateLabel("C-Stick", 608, 216, 38, 17)
$Label6 = GUICtrlCreateLabel("UpDown", 576, 240, 46, 17)
$Label7 = GUICtrlCreateLabel("LeftRight", 632, 240, 47, 17)
$Label8 = GUICtrlCreateLabel("Stick", 384, 112, 28, 17)
$Label9 = GUICtrlCreateLabel("LeftRight", 400, 136, 47, 17)
$Label10 = GUICtrlCreateLabel("UpDown", 344, 136, 46, 17)
$Label14 = GUICtrlCreateLabel("Left", 344, 240, 22, 17)
$Label15 = GUICtrlCreateLabel("Down", 382, 272, 32, 17)
$Label16 = GUICtrlCreateLabel("Left Trig.", 344, 40, 46, 17)
$Label17 = GUICtrlCreateLabel("Right Trig", 632, 40, 50, 17)
$Label18 = GUICtrlCreateLabel("Zed", 576, 40, 23, 17)
$Label11 = GUICtrlCreateLabel("Start", 480, 136, 26, 17)
$Label2 = GUICtrlCreateLabel("B", 544, 168, 11, 17)
$Label12 = GUICtrlCreateLabel("Up", 388, 208, 18, 17)
$Label13 = GUICtrlCreateLabel("Right", 424, 240, 29, 17)
$Label19 = GUICtrlCreateLabel("ZedL", 640, 376, 29, 17)

$iStart = GUICtrlCreateDummy()
$cJoy = GUICtrlCreateCombo("", 8, 8, 289-48, 25, BitOR($CBS_DROPDOWN,$CBS_AUTOHSCROLL))
$bJoy = GUICtrlCreateButton("Refresh", 289-48+8, 7, 48,23)
$eRaw = GUICtrlCreateEdit("", 8, 40, 289, 73)
GUICtrlSetData(-1, "")
GUICtrlSetFont(-1, 10, 400, 0, "Lucida Console")
$eIni = GUICtrlCreateEdit("", 8, 120, 289, 305)
GUICtrlSetFont(-1, 10, 400, 0, "Lucida Console")
$iName = GUICtrlCreateInput("Controller Name", 304, 8, 393, 21)

$bA = GUICtrlCreateButton("", 576, 160, 43, 25)
GUICtrlSetBkColor(-1, 0x00FF00)
$bB = GUICtrlCreateButton("", 528, 184, 43, 25)
GUICtrlSetBkColor(-1, 0xFF0000)
$bX = GUICtrlCreateButton("", 576, 112, 43, 25)
$bY = GUICtrlCreateButton("", 624, 136, 43, 25)
$bCStickY = GUICtrlCreateButton("", 576, 256, 43, 25)
GUICtrlSetBkColor(-1, 0xFFFF00)
$bCStickX = GUICtrlCreateButton("", 632, 256, 43, 25)
GUICtrlSetBkColor(-1, 0xFFFF00)
$bStickY = GUICtrlCreateButton("", 344, 152, 43, 25)
$bStickX = GUICtrlCreateButton("", 400, 152, 43, 25)
$bStart = GUICtrlCreateButton("", 472, 152, 43, 25)
$bUp = GUICtrlCreateButton("", 376, 224, 43, 25)
$bRight = GUICtrlCreateButton("", 416, 256, 43, 25)
$bDown = GUICtrlCreateButton("", 376, 288, 43, 25)
$bLeft = GUICtrlCreateButton("", 336, 256, 43, 25)
$bL = GUICtrlCreateButton("", 344, 64, 43, 25)
$bR = GUICtrlCreateButton("", 632, 56, 43, 25)
$bZ = GUICtrlCreateButton("", 568, 56, 43, 25)
GUICtrlSetBkColor(-1, 0x3399FF)

$bWizzard = GUICtrlCreateButton("Set All", 304, 368, 115, 49)
GUICtrlSetFont(-1, 18, 400, 0, "MS Sans Serif")
$bZmod = GUICtrlCreateButton("bZmod", 632, 392, 51, 25)
$bSave = GUICtrlCreateButton("Save", 512, 392, 101, 25)
$cDPAD = GUICtrlCreateCombo("", 424, 368, 81, 25, BitOR($CBS_DROPDOWN,$CBS_AUTOHSCROLL))
GUICtrlSetData(-1, "DPAD = 0|DPAD = 1", "DPAD = 1")
$cPollType = GUICtrlCreateCombo("", 424, 394, 81, 25, BitOR($CBS_DROPDOWN,$CBS_AUTOHSCROLL))
GUICtrlSetData(-1, "PollType = 1|PollType = 0", "PollType = 1")
$Combo1 = GUICtrlCreateCombo("", 512, 368, 89, 25, BitOR($CBS_DROPDOWN,$CBS_AUTOHSCROLL))
GUICtrlSetData(-1, "DigitalLR = 1|DigitalLR = 0", "DigitalLR = 1")
$iEnd = GUICtrlCreateDummy()
#EndRegion ### END Koda GUI section ###

Global $aButtons[17] = [16,"A","B","X","Y","CStickY","CStickX","StickY","StickX","Start","Up","Right","Left","Down","L","R","Z"]
Global $aButtName[17] = [16,"A","B","X","Y","C Stick UP or DOWN","C Stick LEFT or RIGHT","Stick UP or DOWN","Stick LEFT or RIGHT","Start","D-Pad Up","D-Pad Right","D-Pad Left","D-Pad Down","Left Trigger","Right Trigger","Z"]
For $i = 1 to $aButtons[0]
    Assign("v"&$aButtons[$i], -1)
Next
Global $VID, $PID, $JoyName, $WaitForButton = 0
Global $hWin, $hEdit1, $hEdit2, $hCombo
Global $IniPath = @ScriptDir&"\controllers"
DirCreate($IniPath)
ReloadJoyList()
UpdateIni()
HotKeySet("{esc}", "ExitProgram")

GUISetState(@SW_SHOW)

While 1
    $nMsg = GUIGetMsg()
    Switch $nMsg
        Case $GUI_EVENT_CLOSE
            Exit

        Case $bJoy
            ProcessClose("hidTrace.exe")
            ProcessClose("hidTrace.exe")
            sleep(200)
            For $i = $iStart To $iEnd
                GUICtrlSetState($i, $GUI_DISABLE)
            Next
            ReloadJoyList()
            ; runs LoadJoy after
            For $i = $iStart To $iEnd
                GUICtrlSetState($i, $GUI_ENABLE)
            Next

        Case $cJoy
            LoadJoy(GUICtrlRead($cJoy))

        Case $bWizzard
            dowizzard()

        Case $iName
            $JoyName = GUICtrlRead($iName)
            UpdateIni()

        Case $bSave
            SaveIni()

    EndSwitch

    For $iButton = 1 to $aButtons[0]
        If $nMsg = Eval("b"&$aButtons[$iButton]) Then
;~             ConsoleWrite(Eval("b"&$aButtons[$iButton])&"    "&"Button "&"$b"&$aButtons[$iButton]&" pushed!"&@CRLF)
            If SetButton($iButton) Then
                UpdateIni()
            EndIf
        EndIf
    Next



    If StringTrimLeft(ControlGetText($hWin, "", $hEdit2), 10) <> GUICtrlRead($eRaw) Then
        GUICtrlSetData($eRaw, StringTrimLeft(ControlGetText($hWin, "", $hEdit2), 10))
    EndIf
WEnd

Func SetButton($iButton, $aBaseline = "")
    ControlFocus($Form1, "", $iName)
    Local $i, $timer = TimerInit()
    If $aBaseline = "" or Not IsArray($aBaseline) Then
;~         MsgBox(0, "Setup Wizzard", "Release all buttons / sticks and click ok to continue")
        $aBaseline = StringRegExp(StringTrimLeft(ControlGetText($hWin, "", $hEdit2), 10), " ([0-9a-fA-F]{2})(?= )", 3)
        If Not IsArray($aBaseline) Then
            SplashOff()
            MsgBox(0, "Error", "Error creating baseline! Make sure controller is on and plugged in")
            Return -1
        EndIf
    EndIf
    Local $aCurrentState
;~     _ArrayDisplay($aBaseline)
    SplashTextOn("", "Press "&$aButtName[$iButton]&" to set, SPACE to skip, or ESC to cancel", 200, 150)

    $WaitForButton = 1
    While $WaitForButton
;~         If TimerDiff($timer) > 5000 Then ExitLoop
        If StringTrimLeft(ControlGetText($hWin, "", $hEdit2), 10) <> GUICtrlRead($eRaw) Then
            GUICtrlSetData($eRaw, StringTrimLeft(ControlGetText($hWin, "", $hEdit2), 10))
        EndIf
        $aCurrentState = StringRegExp(StringTrimLeft(ControlGetText($hWin, "", $hEdit2), 10), " ([0-9a-fA-F]{2})(?= )", 3)
        If Not IsArray($aCurrentState) Then
            SplashOff()
            MsgBox(0, "Error", "Error creating baseline! Make sure controller is on and plugged in")
            Return -1
        EndIf
        For $i = 0 to UBound($aBaseline)-1
            ;$temp will store the difference of the two hex bytes being examined
            $temp = Dec($aCurrentState[$i])-Dec($aBaseline[$i])
            ;seperate handleing for sticks. Make sure the difference is more than an amount, to help prevent accidental buttons
            If StringInStr($aButtons[$iButton], "stick") Then
                If Abs($temp) > 20 Then
                    ConsoleWrite("1> Change at index "&$i&" from "&$aBaseline[$i]&" to "&$aCurrentState[$i]&@CRLF)
                    ConsoleWrite($aButtons[$iButton]&"="&$i  &@CRLF)
                    $WaitForButton = 0
                    SplashOff()

                    GUICtrlSetData(Eval("b"&$aButtons[$iButton]), $i)
                    Assign("v"&$aButtons[$iButton], $i)
                    Return 1
                EndIf

            Else ; handleing for button, just check difference
                If $temp > 1 Then
                    ConsoleWrite("2> Change at index "&$i&" from "&$aBaseline[$i]&" to "&$aCurrentState[$i]&@CRLF)
                    ConsoleWrite($aButtons[$iButton]&"="&$i&","&  hex($temp, 2)  &@CRLF)
                    $WaitForButton = 0
                    SplashOff()

                    GUICtrlSetData(Eval("b"&$aButtons[$iButton]), $i&","&  hex($temp, 2))
                    Assign("v"&$aButtons[$iButton], $i&","&  hex($temp, 2) )
                    Return 1
                ElseIf $temp < 0 Then ; Special handleing: IF the difference is negitive, then chances are you need the absolute
                    ConsoleWrite("3> Change at index "&$i&" from "&$aBaseline[$i]&" to "&$aCurrentState[$i]&@CRLF)
                    ConsoleWrite($aButtons[$iButton]&"="&$i&","&  $aCurrentState[$i]  &@CRLF)
                    $WaitForButton = 0
                    SplashOff()

                    GUICtrlSetData(Eval("b"&$aButtons[$iButton]), $i&","&  $aCurrentState[$i])
                    Assign("v"&$aButtons[$iButton], $i&","&  $aCurrentState[$i] )
                    Return 1
                EndIf
            EndIf
        Next
    WEnd
    $WaitForButton = 0
    SplashOff()
    Return -1

EndFunc

Func WaitForRelease($aBaseline)
    Local $aCurrentState, $i, $timer = TimerInit()
    sleep(200)
    while sleep(100)
        $aCurrentState = StringRegExp(StringTrimLeft(ControlGetText($hWin, "", $hEdit2), 10), " ([0-9a-fA-F]{2})(?= )", 3)
        If Not IsArray($aCurrentState) Then
            SplashOff()
            MsgBox(0, "Error", "Error getting controller state! Make sure controller is on and plugged in")
            Return -1
        EndIf
        For $i = 0 to UBound($aBaseline)-1
            ;$temp will store the difference of the two hex bytes being examined
            If $aCurrentState[$i] <> $aBaseline[$i] Then ExitLoop
            If $i = UBound($aBaseline)-1 Then Return 1
        Next
        If TimerDiff($timer) > 5000 Then ExitLoop
    WEnd
    return 0
EndFunc

Func UpdateIni()
    Local $i, $s = "", $temp
    $s = "["&$JoyName&"]"&@CRLF&"VID="&$VID&@CRLF&"PID="&$PID&@CRLF

    For $i = 1 to $aButtons[0]
        $temp = Eval("v"&$aButtons[$i])
;~         ConsoleWrite("> "&$aButtons[$i]&" = "&$temp&"    "&($temp <> -1)&@CRLF)
        If $temp <> -1 Then $s &= $aButtons[$i]&"="&$temp&@CRLF
    Next
    GUICtrlSetData($eIni, $s)
EndFunc

Func SaveIni()
    Local $temp = $IniPath&"\"&$VID&"_"&$PID&".ini"
    If Not FileExists($temp) or MsgBox(4, "File exists!",$VID&"_"&$PID&".ini already exists in the folder"&@CRLF&$IniPath&@CRLF&"Do you want to overwrite it?") = 6 Then
        FileRecycle($temp)
        FileWrite($temp, GUICtrlRead($eIni))
    EndIf
    ; clear the gui messages in case the user hit gui buttons while the msgbox was up
    While GUIGetMsg() <> 0
    WEnd
EndFunc

Func LoadIni()
    Local $temp, $iButton, $path = $IniPath&"\"&$VID&"_"&$PID&".ini"
    ConsoleWrite("+  "&$IniPath&"\"&$VID&"_"&$PID&".ini"&@CRLF)
    If Not FileExists($path) Then return 0

    $temp = IniReadSectionNames($path)
    If not IsArray($temp) Then return -1
    $JoyName = $temp[1]
    ConsoleWrite("Loaded joystick named: "&$JoyName&@CRLF)

    For $iButton = 1 to $aButtons[0]
        $temp = IniRead($path, $JoyName, $aButtons[$iButton], -1)
        Assign("v"&$aButtons[$iButton], $temp)
        If $temp > -1 Then GUICtrlSetData(Eval("b"&$aButtons[$iButton]), $temp)
    Next

    ; clear the gui messages in case the user hit gui buttons while the msgbox was up
    While GUIGetMsg() <> 0
    WEnd
    UpdateIni()
EndFunc

Func dowizzard()
    MsgBox(0, "Setup Wizzard", "Release all buttons / sticks and click ok to continue")
    Local $i, $aBaseline = StringRegExp(StringTrimLeft(ControlGetText($hWin, "", $hEdit2), 10), " ([0-9a-fA-F]{2})(?= )", 3)
    For $iButton = 1 to $aButtons[0]
        If SetButton($iButton) = -1 Then ExitLoop
        If WaitForRelease($aBaseline) <> 1 Then
            SplashOff()
            $WaitForButton = 0
            MsgBox(0, "Error", "Button jammed / not released after setting "&$aButtName[$iButton]&"!"&@CRLF&"Check controller and try again.")
            Return -1
        EndIf
    Next
    $WaitForButton = 0
    UpdateIni()
EndFunc

Func ExitProgram()
    If $WaitForButton = 1 Then
        $WaitForButton = 0
    Else
        Exit
    EndIf
EndFunc

Func ReloadJoyList()
    Run("hidTrace.exe", "", @SW_HIDE)
    $hWin = WinWait("HID Trace - (c) Atomix Productions 2009", "", 2)
    $hCombo = ControlGetHandle($hWin, "", "[CLASS:ComboBox; INSTANCE:1]")
    $hEdit1 = ControlGetHandle($hWin, "", "[CLASS:Edit; INSTANCE:1]")
    $hEdit2 = ControlGetHandle($hWin, "", "[CLASS:Edit; INSTANCE:2]")
    WinActivate($Form1)

    if Not $hCombo Then Exit MsgBox(0, "Error", "Could not run HidTrace (no window found!)")
    $joyList = StringRegExpReplace(_GUICtrlComboBox_GetList($hCombo), "(\d{1,5}e? \/ \d{1,5}e?\|?)", "")
    ConsoleWrite('"'&$joyList&'"'&@CRLF)
    If $joyList = "" Then
;~         MsgBox(0, "Error", "No controllers found! Check controllers and re-run this program")
        $joyList = "None found - Hit Refresh"
    EndIf
    If StringInStr($joyList, GUICtrlRead($cJoy)) Then
        $temp = GUICtrlRead($cJoy)
        GUICtrlSetData($cJoy, "")
        GUICtrlSetData($cJoy, $joyList, $temp)
    Else
        GUICtrlSetData($cJoy, "")
        Local $temp = StringSplit($joyList, "|")
        GUICtrlSetData($cJoy, $joyList, $temp[1])
    EndIf
    LoadJoy(GUICtrlRead($cJoy))
    UpdateIni()
EndFunc

func LoadJoy($sName)
    ConsoleWrite("LoadJoy("&$sName&")"&@CRLF)
    ; assign default values
    $VID = 0
    $PID = 0
    For $i = 1 to $aButtons[0]
        Assign("v"&$aButtons[$i], -1)
    Next
    $JoyName = $sName
    ControlCommand($hWin, "", $hCombo, "SelectString", $sName)
    $a = StringRegExp(ControlGetText($hWin, "", $hEdit1), "VID=([0-9a-fA-F)]{4})\|PID=([0-9a-fA-F)]{4})", 3)
    If @error Then return -1
    $VID = $a[0]
    $PID = $a[1]

    LoadIni()

    ;attempt name lookup from ID's
    If $usbIDs <> "" Then
        Local $temp = StringRegExp($usbIDs, $VID&" [^\r\n]*[\r\n]*\s*"&$PID&"\s\s([^\r\n]*)", 3)
        If UBound($temp) = 1 Then
            $JoyName = $temp[0]
        EndIf
    EndIf

    GUICtrlSetData($iName, $JoyName)
EndFunc


Func onExit()
    ProcessClose("hidTrace.exe")
EndFunc
