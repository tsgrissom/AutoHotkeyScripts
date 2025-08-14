; WINDOWS HOTKEYS

#Requires AutoHotkey v2.0
#SingleInstance Force

; --- Imports ---

#Include "By Program\Flow Launcher.ahk"

; --- Constants ---

ExecutableNameTerminal := "WindowsTerminal.exe"
ExecutableNameNotepadPlusPlus := "notepad++.exe"

WindowSelectorTerminal := Format("ahk_exe {}", ExecutableNameTerminal)
WindowSelectorNotepadPlusPlus := Format("ahk_exe {}", ExecutableNameNotepadPlusPlus)

; --- OS Navigation Hotkeys ---

; Hotkey (Win+N): Opens Notepad++
#n:: {
    if WinExist(WindowSelectorNotepadPlusPlus) {
        WinActivate
        SendInput "^{n}"
    } else {
        Run "Notepad++"
        ; TODO Finish
        if not WinWaitActive("Notepad++") {
            MsgBox "Something went wrong: Notepad++ was not active when it should have been"
        } else {
            WinActivate
        }
    }
}

; TODO Replace Win+X
#x::MsgBox("Hello!")

; Hotkey (Win+Alt+D): Opens Downloads in Windows Explorer
#!d:: {
    ; TODO Check if explorer already exists, if so open it there, otherwise do the below
    Run "explorer C:\Users\Tyler\Downloads"
}

; Hotkey (Win+T): Opens Windows Terminal
#t:: {
    if not WinExist(WindowSelectorTerminal) {
        Run "wt"
        Sleep 300
        WinActivate(WindowSelectorTerminal)
    } else {
        WinActivate
        Send "^+{T}"
    }
}

; --- Program-Specific Hotkeys ---

; Windows Terminal
#HotIf WinActive(WindowSelectorTerminal)
^w:: SendInput "^+w"

; File Explorer
#HotIf WinActive("ahk_exe explorer.exe")
; Hotkey (F3): Creates a new folder by triggering the built-in keyboard shortcut
F3:: SendInput "^+{N}"