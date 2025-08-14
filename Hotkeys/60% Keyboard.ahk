; ABOUT: Hotkeys for users of keyboards which lack dedicated arrow keys, such as 60% keyboards. Maps Alt+WASD and Shift+Alt+WASD to the corresponding directional arrow keys.

#Requires AutoHotkey v2.0
#SingleInstance Force
Persistent
SendMode "Input"

; --- Variables ---

KEY_CODE_MOVE_UP := "W"
KEY_CODE_MOVE_LEFT := "A"
KEY_CODE_MOVE_DOWN := "S"
KEY_CODE_MOVE_RIGHT := "D"

; --- Functions ---

PressArrowKey(direction) {
    modifiers := ""

    if (GetKeyState("Shift", "P")) {
        modifiers .= "+"
    }

    Send modifiers "{" direction "}"
}

; --- Character Hotkeys ---

; Hotkey (Ctrl+Q): Sends a Tilde ~ character
^q:: Send "~"
; Hotkey (Alt+Q): Sends a Backtick ` character
!q:: Send "``"

; --- Directional Arrow Hotkeys ---

; Hotkey (Alt+W): Triggers Up arrow key
Hotkey("*!" . KEY_CODE_MOVE_UP, (*) => PressArrowKey("Up"))
; Hotkey (Alt+A): Triggers Left arrow key
Hotkey("*!" . KEY_CODE_MOVE_LEFT, (*) => PressArrowKey("Left"))
; Hotkey (Alt+S): Triggers Down arrow key
Hotkey("*!" . KEY_CODE_MOVE_DOWN, (*) => PressArrowKey("Down"))
; Hotkey (Alt+D): Triggers Right arrow key
Hotkey("*!" . KEY_CODE_MOVE_RIGHT, (*) => PressArrowKey("Right"))