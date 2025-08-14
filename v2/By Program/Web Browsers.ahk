; DISCLAIMER: In theory, this script supports the listed browsers in variable Browsers, but this has not been tested outside of MS Edge.

#Requires AutoHotkey v2.0
#SingleInstance Force
SendMode "Input"

Browsers := ["ahk_exe msedge.exe", "ahk_exe chrome.exe", "ahk_exe firefox.exe", "ahk_exe opera.exe", "ahk_exe operagx.exe"]
IsBrowser := false

for Browser in Browsers {
    IsBrowser := IsBrowser or WinActive(Browser)
}

#HotIf IsBrowser

ScrollTabs(Previous) {
    DirectionalKey := Previous ? "{Shift down}" : ""
    Inp := "{Alt up}{Tab up}{Ctrl down}" . DirectionalKey . "{Tab down}{Ctrl up}{Shift up}{Tab up}"
    Send Inp
    Sleep 75
}

ChangePage(Forward) { ; Supplied w/ a boolean representing directions forward (right) & backwards (left)
    Direction := Forward ? "Right" : "Left"
    Inp := "{Alt down}{" . Direction . " down}{Alt up}{" . Direction . " up}"
    Send Inp
    Sleep 500
}

!WheelUp::ScrollTabs(Previous := true)
!WheelDown::ScrollTabs(Previous := false)

+WheelUp::ChangePage(Forward := false)
+WheelDown::ChangePage(Forward := true)