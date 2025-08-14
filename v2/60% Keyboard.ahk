; ABOUT: Hotkeys for users of keyboards which lack dedicated arrow keys, such as 60% keyboards. Maps Alt+WASD and Shift+Alt+WASD to the corresponding directional arrow keys.

#Requires AutoHotkey v2.0
#SingleInstance Force
Persistent
SendMode "Input"

; --- Variables ---

MovementKeyUp := "W"
MovementKeyLeft := "A"
MovementKeyDown := "S"
MovementKeyRight := "D"

; --- Helper Functions ---

PressArrowKey(Direction) {
    modifiers := ""

    if (GetKeyState("Shift", "P")) {
        modifiers .= "+"
    }

    Send modifiers "{" Direction "}"
}

; --- Character Hotkeys ---

; Hotkey (Ctrl+Q): Sends a Tilde ~ character
^q:: Send "~"
; Hotkey (Alt+Q): Sends a Backtick ` character
!q:: Send "``"

; --- Directional Arrow Hotkeys ---

; Hotkey (Alt+W): Triggers Up arrow key
Hotkey("*!" . MovementKeyUp, (*) => PressArrowKey("Up"))
; Hotkey (Alt+A): Triggers Left arrow key
Hotkey("*!" . MovementKeyLeft, (*) => PressArrowKey("Left"))
; Hotkey (Alt+S): Triggers Down arrow key
Hotkey("*!" . MovementKeyDown, (*) => PressArrowKey("Down"))
; Hotkey (Alt+D): Triggers Right arrow key
Hotkey("*!" . MovementKeyRight, (*) => PressArrowKey("Right"))