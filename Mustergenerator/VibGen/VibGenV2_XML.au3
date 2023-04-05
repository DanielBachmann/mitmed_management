# ******************************************************************
#
#    Vibrations-Generator für MITMED Manschette2.bmp
#
#	 es können interaktiv Muster generiert werden.
#
#	 Es werden xml templates erzeugt, die dann in die mobile nRfConnect App
#	 importiert werden können.
#
# ******************************************************************



#include <ButtonConstants.au3>
#include <EditConstants.au3>
#include <GUIConstantsEx.au3>
#include <StaticConstants.au3>
#include <WindowsConstants.au3>
#include <Array.au3>

#Region ### START Koda GUI section ### Form=
$Form1_1 = GUICreate("MITmed Vibrations-Muster-Generator ", 623, 411, 282, 197)
$btnNew = GUICtrlCreateButton("Neues Muster", 24, 368, 99, 25)
$btnAdd = GUICtrlCreateButton("Hinzufügen", 312, 368, 99, 25)
$Group1 = GUICtrlCreateGroup("PWM", 456, 24, 65, 249)
$PWM1 = GUICtrlCreateRadio("1", 464, 40, 25, 17)
$PWM2 = GUICtrlCreateRadio("2", 464, 63, 25, 17)
$PWM3 = GUICtrlCreateRadio("3", 464, 86, 25, 17)
$PWM4 = GUICtrlCreateRadio("4", 464, 109, 25, 17)
$PWM5 = GUICtrlCreateRadio("5", 464, 132, 25, 17)
$PWM6 = GUICtrlCreateRadio("6", 464, 155, 25, 17)
$PWM7 = GUICtrlCreateRadio("7", 464, 178, 25, 17)
$PWM8 = GUICtrlCreateRadio("8", 464, 201, 25, 17)
$PWM9 = GUICtrlCreateRadio("9", 464, 224, 33, 17)
$PWM10 = GUICtrlCreateRadio("10", 464, 248, 41, 17)
GUICtrlCreateGroup("", -99, -99, 1, 1)
$Label1 = GUICtrlCreateLabel("Dauer [ms]", 528, 232, 55, 17)
$Duration = GUICtrlCreateInput("200", 528, 252, 65, 21)
$Group2 = GUICtrlCreateGroup("Vibratoren", 16, 24, 425, 313)
$Vib1 = GUICtrlCreateCheckbox("1", 352, 248, 33, 17)
$Vib2 = GUICtrlCreateCheckbox("2", 352, 200, 33, 17)
$Vib3 = GUICtrlCreateCheckbox("3", 352, 168, 33, 17)
$Vib4 = GUICtrlCreateCheckbox("4", 352, 112, 33, 17)
$Vib5 = GUICtrlCreateCheckbox("5", 232, 160, 33, 17)
$Vib6 = GUICtrlCreateCheckbox("6", 64, 112, 33, 17)
$Vib7 = GUICtrlCreateCheckbox("7", 64, 152, 33, 17)
$Vib8 = GUICtrlCreateCheckbox("8", 72, 208, 33, 17)
$Vib9 = GUICtrlCreateCheckbox("9", 72, 248, 33, 17)
$Pic1 = GUICtrlCreatePic("Manschette2.bmp", 32, 40, 396, 292)
GUICtrlCreateGroup("", -99, -99, 1, 1)
$Label2 = GUICtrlCreateLabel("Datei: bitte auswählen", 136, 368, 161, 24)
GUICtrlSetFont(-1, 12, 400, 0, "MS Sans Serif")
$btnSave = GUICtrlCreateButton("Speichern", 504, 368, 91, 25)
$Label3 = GUICtrlCreateLabel("Überlappung", 528, 282, 71, 17)
$EditOverlap = GUICtrlCreateInput("0", 528, 302, 65, 21)
$Group3 = GUICtrlCreateGroup("Start", 528, 24, 73, 121)
$doPrePulse = GUICtrlCreateCheckbox("Pre-Puls", 536, 48, 97, 17)
$Label4 = GUICtrlCreateLabel("Überlappung", 1056, 306, 71, 17)
$Label5 = GUICtrlCreateLabel("Pulsdauer", 530, 77, 55, 17)
$PrePulsMs = GUICtrlCreateInput("30", 532, 99, 41, 21)
$Label6 = GUICtrlCreateLabel("ms", 574, 97, 23, 17)
GUICtrlCreateGroup("", -99, -99, 1, 1)
GUISetState(@SW_SHOW)
#EndRegion ### E

# Ansprechen, damit die Controls vor dem Bild liegen.
GUICtrlSetState($VIB1,$GUI_CHECKED )
GUICtrlSetState($VIB2,$GUI_CHECKED )
GUICtrlSetState($VIB3,$GUI_CHECKED )
GUICtrlSetState($VIB4,$GUI_CHECKED )
GUICtrlSetState($VIB5,$GUI_CHECKED )
GUICtrlSetState($VIB6,$GUI_CHECKED )
GUICtrlSetState($VIB7,$GUI_CHECKED )
GUICtrlSetState($VIB8,$GUI_CHECKED )
GUICtrlSetState($VIB9,$GUI_CHECKED )
GUICtrlSetState($VIB1,$GUI_UNCHECKED )
GUICtrlSetState($VIB2,$GUI_UNCHECKED )
GUICtrlSetState($VIB3,$GUI_UNCHECKED )
GUICtrlSetState($VIB4,$GUI_UNCHECKED )
GUICtrlSetState($VIB5,$GUI_UNCHECKED )
GUICtrlSetState($VIB6,$GUI_UNCHECKED )
GUICtrlSetState($VIB7,$GUI_UNCHECKED )
GUICtrlSetState($VIB8,$GUI_UNCHECKED )
GUICtrlSetState($VIB9,$GUI_UNCHECKED )

GUICtrlSetState($PWM5,$GUI_CHECKED )

global $fn = ""
global $startTime = 0;
global $index = 0
dim $pattern[102][3]

$xmlTemplate = "template.xml"

func eraseArray()
	for $i = 0 to 101
		$pattern[$i][0] = 50000;
		$pattern[$i][1] = 0;
		$pattern[$i][2] = 0;
	Next
EndFunc

Func newFile()
	$num = InputBox("Neues Muster anlegen","Muster-Name");
	if $num <> "" then
		$fn="FB" & $num & ".xml"
		GUICtrlSetData($Label2,$fn)
		$startTime = 0;

	EndIf
	ConsoleWrite($num & @cr)
	$index = 0
EndFunc

Func addLine()
	if $fn = "" then
		MsgBox(48,"Warnung","Zuerst neues Muster anlegen")
		return
	EndIf
	$pwm = 0
	$overlap = GUICtrlRead($EditOverlap)
	if GUICtrlRead($PWM1) = $GUI_CHECKED then
		$pwm = 25
	EndIf
	if GUICtrlRead($PWM2) = $GUI_CHECKED then
		$pwm = 50
	EndIf
	if GUICtrlRead($PWM3) = $GUI_CHECKED then
		$pwm = 75
	EndIf
	if GUICtrlRead($PWM4) = $GUI_CHECKED then
		$pwm = 100
	EndIf
	if GUICtrlRead($PWM5) = $GUI_CHECKED then
		$pwm = 125
	EndIf
	if GUICtrlRead($PWM6) = $GUI_CHECKED then
		$pwm = 150
	EndIf
	if GUICtrlRead($PWM7) = $GUI_CHECKED then
		$pwm = 175
	EndIf
	if GUICtrlRead($PWM8) = $GUI_CHECKED then
		$pwm = 200
	EndIf
	if GUICtrlRead($PWM9) = $GUI_CHECKED then
		$pwm = 225
	EndIf
	if GUICtrlRead($PWM10) = $GUI_CHECKED then
		$pwm = 255
	EndIf
	$ms = GUICtrlRead($Duration)
	if GUICtrlRead($doPrePulse) = $GUI_CHECKED then
		$pp = GUICtrlRead($PrePulsMs)
	else
		$pp = 0
	EndIf
	if GUICtrlRead($VIB1) = $GUI_CHECKED then
		if GUICtrlRead($doPrePulse) = $GUI_CHECKED then
			addVibPP(1,255,$pp)
		EndIf
		addVib(1,$pwm,$ms)
	EndIf
	if GUICtrlRead($VIB2) = $GUI_CHECKED then
		if GUICtrlRead($doPrePulse) = $GUI_CHECKED then
			addVibPP(2,255,$pp)
		EndIf
		addVib(2,$pwm,$ms)
	EndIf
	if GUICtrlRead($VIB3) = $GUI_CHECKED then
		if GUICtrlRead($doPrePulse) = $GUI_CHECKED then
			addVibPP(3,255,$pp)
		EndIf
		addVib(3,$pwm,$ms)
	EndIf
	if GUICtrlRead($VIB4) = $GUI_CHECKED then
		if GUICtrlRead($doPrePulse) = $GUI_CHECKED then
			addVibPP(4,255,$pp)
		EndIf
		addVib(4,$pwm,$ms)
	EndIf
	if GUICtrlRead($VIB5) = $GUI_CHECKED then
		if GUICtrlRead($doPrePulse) = $GUI_CHECKED then
			addVibPP(5,255,$pp)
		EndIf
		addVib(5,$pwm,$ms)
	EndIf
	if GUICtrlRead($VIB6) = $GUI_CHECKED then
		if GUICtrlRead($doPrePulse) = $GUI_CHECKED then
			addVibPP(6,255,$pp)
		EndIf
		addVib(6,$pwm,$ms)
	EndIf
	if GUICtrlRead($VIB7) = $GUI_CHECKED then
		if GUICtrlRead($doPrePulse) = $GUI_CHECKED then
			addVibPP(7,255,$pp)
		EndIf
		addVib(7,$pwm,$ms)
	EndIf
	if GUICtrlRead($VIB8) = $GUI_CHECKED then
		if GUICtrlRead($doPrePulse) = $GUI_CHECKED then
			addVibPP(8,255,$pp)
		EndIf
		addVib(8,$pwm,$ms)
	EndIf
	if GUICtrlRead($VIB9) = $GUI_CHECKED then
		if GUICtrlRead($doPrePulse) = $GUI_CHECKED then
			addVibPP(9,255,$pp)
		EndIf
		addVib(9,$pwm,$ms)
	EndIf
		$startTime = $StartTime + $ms + $pp


	ConsoleWrite('@@ Debug(' & @ScriptLineNumber & ') : $startTime = ' & $startTime & @CRLF & '>Error code: ' & @error & @CRLF) ;### Debug Console
	GUICtrlSetState($VIB1,$GUI_UNCHECKED )
	GUICtrlSetState($VIB2,$GUI_UNCHECKED )
	GUICtrlSetState($VIB3,$GUI_UNCHECKED )
	GUICtrlSetState($VIB4,$GUI_UNCHECKED )
	GUICtrlSetState($VIB5,$GUI_UNCHECKED )
	GUICtrlSetState($VIB6,$GUI_UNCHECKED )
	GUICtrlSetState($VIB7,$GUI_UNCHECKED )
	GUICtrlSetState($VIB8,$GUI_UNCHECKED )
	GUICtrlSetState($VIB9,$GUI_UNCHECKED )


EndFunc

func addVib($num,$pwm,$ms)
	ConsoleWrite('@@ Debug(' & @ScriptLineNumber & ') : $num = ' & $num & ' $pwm = ' & $pwm & ' $ms = ' & $ms & @CRLF) ;### Debug Console
	ConsoleWrite('@@ Debug(' & @ScriptLineNumber & ') : $index = ' & $index & @CRLF & '>Error code: ' & @error & @CRLF) ;### Debug Console
    ; einschalten
	if GUICtrlRead($doPrePulse) = $GUI_CHECKED then
		$pp = GUICtrlRead($PrePulsMs)
	else
		$pp = 0;
	EndIf
	$overlap = GUICtrlRead($EditOverlap)

	$pattern[$index][0] = $startTime + $pp - $overlap
	$pattern[$index][1] = $num
    $pattern[$index][2] = $pwm
	; ausschalten
	$index +=1;
	$pattern[$index][0] = $startTime + $ms + $pp
    $pattern[$index][1] = $num
    $pattern[$index][2] = 0
	$index +=1;
	if ($index >= 101) then
		MsgBox(48,"Warnung","Maximale Pattern-Länge erreicht")
	endif

EndFunc

func addVibPP($num,$pwm,$ms)
	ConsoleWrite('@@ Debug(' & @ScriptLineNumber & ') : $num = ' & $num & ' $pwm = ' & $pwm & ' $ms = ' & $ms & @CRLF) ;### Debug Console
	ConsoleWrite('@@ Debug(' & @ScriptLineNumber & ') : $index = ' & $index & @CRLF & '>Error code: ' & @error & @CRLF) ;### Debug Console
	$overlap = GUICtrlRead($EditOverlap)
    ; einschalten
    $pattern[$index][0] = $startTime - $overlap
	$pattern[$index][1] = $num
    $pattern[$index][2] = $pwm
	; nicht ausschalten
	$index +=1;
	if ($index >= 101) then
		MsgBox(48,"Warnung","Maximale Pattern-Länge erreicht")
	endif

EndFunc


Func saveData()

	_ArraySort($pattern,0)

	; in Datei schreiben
	FileDelete($fn)
	$value = "";
	for $i = 0 to $index-1
		$ms = int($pattern[$i][0])
		$time = int($pattern[$i][0])

		$th = int($time / 256);
		$tl = Mod($time,256);
		ConsoleWrite($tl & " " & $th & @CRLF) ;### Debug Console
;		$line = Hex(int($pattern[$i][0]),4)  & Hex(int($pattern[$i][2]),2) & Hex(int($pattern[$i][1]),2);
		$line = Hex($tl,2)  & Hex($th,2)  & Hex(int($pattern[$i][2]),2) & Hex(int($pattern[$i][1]),2);
		$value = $value & $line ; anhängen
;		FileWrite($fn,$line)
		ConsoleWrite('@@ Debug(' & @ScriptLineNumber & ') : $line = ' & $line & @CRLF & '>Error code: ' & @error & @CRLF) ;### Debug Console
	Next
	$line = "FFFF";
	$value = $value & $line ; anhängen
;	FileWriteLine($fn,$line)
	$xml = FileRead($xmlTemplate) ; gesamte Template einlesen
	$xml = StringReplace($xml,"$$Value$$",$value);
    FileWriteLine($fn,$xml)

	$fn = ""
	GUICtrlSetData($Label2,$fn)
	eraseArray()

EndFunc

Func saveDataOld()
	; Array sortieren
	;_ArrayDisplay($pattern)
	_ArraySort($pattern,0)
	;_ArrayDisplay($pattern)
	; gleiche ms-Einträge anpassen
	$lastValue = -1
	$inc = 5
	for $i = 0 to $index-1
	    if $pattern[$i][0] <> $lastValue then
		     $lastValue = $pattern[$i][0]  ; neuer Wert
			 $inc = 5
		else ; Wert ist gleich, muss inkrementiert werden.
		  $pattern[$i][0] += $inc
		  $inc += 5
		EndIf
	Next
	;_ArrayDisplay($pattern)
	; in Datei schreiben
	FileDelete($fn)
	for $i = 0 to $index-1
		$ms = int($pattern[$i][0])
		$line = Hex(int($pattern[$i][0]),4) & Hex(int($pattern[$i][1]),2) & Hex(int($pattern[$i][2]),2);
		FileWriteLine($fn,$line)
		ConsoleWrite('@@ Debug(' & @ScriptLineNumber & ') : $line = ' & $line & @CRLF & '>Error code: ' & @error & @CRLF) ;### Debug Console
	Next
	$line = "FFFF0000";
	FileWriteLine($fn,$line)
	$fn = ""
	GUICtrlSetData($Label2,$fn)
	eraseArray()

EndFunc


eraseArray()

While 1
	$nMsg = GUIGetMsg()
	Switch $nMsg
		Case $GUI_EVENT_CLOSE
			Exit
		Case $btnNew
			newFile()
		Case $btnAdd
			addLine()
		Case $btnSave
			saveData()
	EndSwitch
WEnd
