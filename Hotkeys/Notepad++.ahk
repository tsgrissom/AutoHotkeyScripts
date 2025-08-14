; NOTEPAD++ HOTKEYS

#Requires AutoHotkey v2.0
#SingleInstance Force
#HotIf WinActive("ahk_exe notepad++.exe")

; Hotkey: Alt+Q or Alt+WheelUp
; Open previous tab
!q::
!WheelUp:: SendInput "^{PgUp}"

; Hotkey: Alt+E or Alt+WheelDown
; Open next tab
!e::
!WheelDown:: SendInput "^{PgDn}"