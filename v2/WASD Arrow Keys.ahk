; ABOUT: Hotkeys for users of keyboards which lack dedicated arrow keys, such as 60% keyboards. Maps Alt+WASD and Shift+Alt+WASD to the corresponding directional arrow keys.

#Requires AutoHotkey v2.0
#SingleInstance Force
Persistent
SendMode "Input"

; Function which makes the directional arrow hotkeys below a bit more DRY
PressArrowKey(Direction, HoldShift := false) {
    Inp := (HoldShift ? "{Shift down}{" : "{") . Direction . (HoldShift ? "}{Shift up}" : "}")
    Send Inp
}

; Hotkey (Ctrl+Q): Sends a Tilde ~ character
^q:: Send "~"
; Hotkey (Alt+Q): Sends a Backtick ` character
!q:: Send "``"

; Hotkey (Alt+W): Triggers Up arrow key
!w:: PressArrowKey("Up")
; Hotkey (Alt+A): Triggers Left arrow key
!a:: PressArrowKey("Left")
; Hotkey (Alt+S): Triggers Down arrow key
!s:: PressArrowKey("Down")
; Hotkey (Alt+D): Triggers Right arrow key
!d:: PressArrowKey("Right")

; Hotkey (Shift+Alt+W): Triggers Up arrow key
+!w:: PressArrowKey("Up", true)
; Hotkey (Shift+Alt+A): Triggers Left arrow key
+!a:: PressArrowKey("Left", true)
; Hotkey (Shift+Alt+S): Triggers Down arrow key
+!s:: PressArrowKey("Down", true)
; Hotkey (Shift+Alt+D): Triggers Right arrow key
+!d:: PressArrowKey("Right", true)