#Requires AutoHotkey v2.0
#SingleInstance Force

; --- Environment ---
A_LocalAppData := EnvGet("LocalAppData")

; --- Constants ---
EXECUTABLE_NAME := "Flow.Launcher.exe"
WINDOW_SELECTOR := "ahk_exe " EXECUTABLE_NAME
PROGRAM_DIRECTORY := A_LocalAppData "\FlowLauncher"
EXECUTABLE_PATH := PROGRAM_DIRECTORY "\" EXECUTABLE_NAME

; --- Variables ---
isDebuggingActive := false

; --- Functions ---

Notify(message) {
    TrayTip("Flow Launcher", message, 1)
}

NotifyDebug(message) {
    global isDebuggingActive

    if (!isDebuggingActive) {
        return
    }

    TrayTip("Flow Launcher (Debug)", message, 1)
}

SendOpenLauncherHotkey() {
    Send("{Blind}#!{Space}")
}

RunProgram(shouldFocus := true) {
    Run(PROGRAM_DIRECTORY . "\" . EXECUTABLE_NAME)
    
    if (!shouldFocus) {
        return
    }

    NotifyDebug("Waiting for Flow Launcher to initialize...")

    ; TODO This doesn't work
    if (ProcessWait(EXECUTABLE_NAME, 1)) {
        ; NotifyDebug("Flow Launcher process exists. Sleeping 700ms for initialize...")
        Sleep 700
        ; NotifyDebug("Sending Flow Launcher hotkey...")
        SendOpenLauncherHotkey()
        ; NotifyDebug("Sent Flow Launcher hotkey")
    } else {
        Notify("Error: Flow Launcher took too long to start")
    }
}

; --- Hotkeys ---

; Hotkey: Press Win+Space to open Flow Launcher
#Space:: {
    if (ProcessExist(EXECUTABLE_NAME)) {
        NotifyDebug("Program already open. Focusing with hotkey...")
        SendOpenLauncherHotkey()
    } else {
        Notify("Running Flow Launcher...")
        RunProgram(false)        
    }
}

; Hotkey: Debug tool to kill Flow Launcher process
!X:: {
    if (!isDebuggingActive) {
        return
    }

    if (!ProcessExist(EXECUTABLE_NAME)) {
        NotifyDebug("Failed to terminate Flow Launcher because it is not running")
        return
    }

    NotifyDebug("Terminating Flow Launcher process...")
    ProcessClose(EXECUTABLE_NAME)

    if (ProcessWaitClose(EXECUTABLE_NAME, 1)) {
        Notify("Error: Failed to terminate Flow Launcher process")
    } else {
        NotifyDebug("Flow Launcher terminated")
    }
}