; WINDOWS HOTKEYS

#Requires AutoHotkey v2.0
#SingleInstance Force

; --- Imports ---

#Include "By Program\Flow Launcher.ahk"

; --- Constants ---

EXECUTABLE_NAME_TERMINAL := "WindowsTerminal.exe"
EXECUTABLE_NAME_NOTEPADPP := "notepad++.exe"

WINDOW_SELECTOR_TERMINAL := "ahk_exe " EXECUTABLE_NAME_TERMINAL
WINDOW_SELECTOR_NOTEPADPP := "ahk_exe " EXECUTABLE_NAME_NOTEPADPP

; --- OS Navigation Hotkeys ---

; Hotkey (Win+N): Opens Notepad++
#n:: {
    if WinExist(WINDOW_SELECTOR_NOTEPADPP) {
        WinActivate()
        Send "^{N}"
    } else {
        Run "Notepad++"
        ; TODO Finish
        if not WinWaitActive("Notepad++") {
            MsgBox "Error: Notepad++ did not start"
        } else {
            WinActivate()
        }
    }
}

; TODO Replace Win+X
#x::MsgBox("Hello!")

; Hotkey (Win+Alt+D): Opens Downloads in Windows Explorer
#!d:: {
    ; TODO Check if explorer already exists, if so open it there, otherwise do the below
    ; TODO Find Downloads folder in a better way
    Run "explorer C:\Users\" A_UserName "\Downloads"
}

; Hotkey (Win+T): Opens Windows Terminal
#t:: {
    if not WinExist(WINDOW_SELECTOR_TERMINAL) {
        Run "wt"
        Sleep 300
        WinActivate(WINDOW_SELECTOR_TERMINAL)
    } else {
        WinActivate()
        Send "^+{T}"
    }
}

; --- Program-Specific Hotkeys ---

; Windows Terminal
#HotIf WinActive(WINDOW_SELECTOR_TERMINAL)
^W:: Send "^+{W}"

; File Explorer
#HotIf WinActive("ahk_exe explorer.exe")
; Hotkey (F3): Creates a new folder by triggering the built-in keyboard shortcut
F3:: Send "^+{N}"