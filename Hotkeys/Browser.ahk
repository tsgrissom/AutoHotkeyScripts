#Requires AutoHotkey v2.0
#SingleInstance Force

EXECUTABLE_NAMES := ["msedge.exe", "chrome.exe", "firefox.exe", "opera.exe", "operagx.exe"]

IsBrowser() {
    for value in EXECUTABLE_NAMES {
        if (WinActive("ahk_exe " value)) {
            return true
        }
    }
    return false
}

ScrollTabs(previous) {
    directionalKey := previous ? "{Shift down}" : ""
    Send "{Alt up}{Tab up}{Ctrl down}" directionalKey "{Tab down}{Ctrl up}{Shift up}{Tab up}"
    Sleep 75
}

ChangePage(forward) {
    direction := forward ? "Right" : "Left"
    Send "{Alt down}{" direction " down}{Alt up}{" direction " up}"
    Sleep 500
}

#HotIf IsBrowser()
!WheelUp::ScrollTabs(Previous := true)
!WheelDown::ScrollTabs(Previous := false)
+WheelUp::ChangePage(Forward := false)
+WheelDown::ChangePage(Forward := true)