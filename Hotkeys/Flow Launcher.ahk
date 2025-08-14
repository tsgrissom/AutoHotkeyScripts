#Requires AutoHotkey v2.0
#SingleInstance Force

; --- Environment ---
A_LocalAppData := EnvGet("LocalAppData")

; --- Constants ---
ExecutableName := "Flow.Launcher.exe"
WindowSelector := Format("ahk_exe {}", ExecutableName)
ProgramDirectory := Format("{}\FlowLauncher", A_LocalAppData)
ExecutablePath := Format("{}\{}", ProgramDirectory, ExecutableName)

; --- Variables ---
isDebuggingActive := false

; --- Functions ---

Notify(Message) {
    TrayTip("Flow Launcher", Message, 1)
}

NotifyDebug(Message) {
    global isDebuggingActive

    if (!isDebuggingActive) {
        return
    }

    TrayTip("Flow Launcher (Debug)", Message, 1)
}

SendOpenLauncherHotkey() {
    Send("{Blind}#!{Space}")
}

RunProgram(ShouldFocus := true) {
    Run(ProgramDirectory . "\" . ExecutableName)
    
    if (!ShouldFocus) {
        return
    }

    NotifyDebug("Waiting for Flow Launcher to initialize...")

    ; TODO This doesn't work
    if (ProcessWait(ExecutableName, 1)) {
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
    if (ProcessExist(ExecutableName)) {
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

    if (!ProcessExist(ExecutableName)) {
        NotifyDebug("Failed to terminate Flow Launcher because it is not running")
        return
    }

    NotifyDebug("Terminating Flow Launcher process...")
    ProcessClose(ExecutableName)

    if (ProcessWaitClose(ExecutableName, 1)) {
        Notify("Error: Failed to terminate Flow Launcher process")
    } else {
        NotifyDebug("Flow Launcher terminated")
    }
}