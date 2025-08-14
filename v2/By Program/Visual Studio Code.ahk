; VISUAL STUDIO CODE HOTKEYS

#Requires AutoHotkey v2.0
#SingleInstance Force
#HotIf WinActive("ahk_exe Code.exe")

; If file saved, cancel existing Code Runner before running it again
^s:: {
    SendInput "^s"
    Sleep 30
    SendInput "^!m"
    Sleep 30
    SendInput "^!n"
}
