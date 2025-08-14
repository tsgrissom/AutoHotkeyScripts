#Requires AutoHotkey v2.0
#SingleInstance Force

; Constants
KeyCodeFireWeapon := "F"
KeyCodeRestartTask := "T"
KeyNameFireWeapon := "Fire Key (" . KeyCodeFireWeapon . ")"
KeyNameRestartTask := "Restart Key (" . KeyCodeRestartTask . ")"

WindowSelectorAimlabs := "ahk_exe AimLab_tb.exe"
WindowSelectorKovaaks := "ahk_exe FPSAimTrainer-Win64-Shipping.exe"

; Variables
isHoldingFireKeyInAimlabs := false
isHoldingFireKeyInKovaaks := false

; Helper Functions
SendFireWeaponKeyDown() {
    Send("{" . KeyCodeFireWeapon . " down}")
}

SendFireWeaponKeyUp() {
    Send("{ " . KeyCodeFireWeapon . " up}")
}

StartHoldingFireKey(AppName) {
    SendFireWeaponKeyDown()
    SendTrayTip(AppName, KeyNameFireWeapon . " is being held")
}

StopHoldingFireKey(AppName) {
    SendFireWeaponKeyUp()
    SendTrayTip(AppName, KeyNameFireWeapon . " was released")
}

ResetScriptState() {
    isHoldingFireKeyInAimlabs := false
    isHoldingFireKeyInKovaaks := false
    SendFireWeaponKeyUp()
}

SendTrayTip(AppName, Message) {
    TrayTip(AppName, Message, 1)
}

; Event Handler Functions
OnPressRestartKey() {
    global isHoldingFireKeyInAimlabs, isHoldingFireKeyInKovaaks
    local text := KeyNameFireWeapon . " was released because the " . KeyNameRestartTask " was pressed"

    if (isHoldingFireKeyInAimlabs) {
        isHoldingFireKeyInAimlabs := false
        SendFireWeaponKeyUp()
        SendTrayTip("Aimlabs", text)

        if (WinActive(WindowSelectorAimlabs)) {
            ; TODO Send other sequences to start task with fire key held again
            Send(KeyCodeRestartTask) ; Pass input on
            Send("Click")
            ; StartHoldingFireKey("Aimlabs (Restarted)")
            SendFireWeaponKeyDown()
            isHoldingFireKeyInAimlabs := true
        }
    }

    if (isHoldingFireKeyInKovaaks) {
        isHoldingFireKeyInKovaaks := false
        SendFireWeaponKeyUp()
        SendTrayTip("KovaaK's", text)

        if (WinActive(WindowSelectorKovaaks)) {
            Send(KeyCodeRestartTask)
            Send("Click")
            ; StartHoldingFireKey("KovaaK's (Restarted)")
            SendFireWeaponKeyDown()
            isHoldingFireKeyInKovaaks := true
        }
    }
}

OnPressToggleFireKey() {
    global isHoldingFireKeyInAimlabs, isHoldingFireKeyInKovaaks

    if (WinActive(WindowSelectorAimlabs)) {
        isHoldingFireKeyInAimlabs := !isHoldingFireKeyInAimlabs

        if (isHoldingFireKeyInAimlabs) {
            StartHoldingFireKey("Aimlabs")
        } else {
            StopHoldingFireKey("Aimlabs")
        }
    }

    if (WinActive(WindowSelectorKovaaks)) {
        isHoldingFireKeyInKovaaks := !isHoldingFireKeyInKovaaks

        if (isHoldingFireKeyInKovaaks) {
            StartHoldingFireKey("KovaaK's")
        } else {
            StopHoldingFireKey("KovaaK's")
        }
    }
}

; Hotkeys: Toggle Fire Key for Aimlabs
#HotIf WinActive(WindowSelectorAimlabs)
; Hotkey: "Alt+F" to toggle Fire Key in Aimlabs
!F::OnPressToggleFireKey
; Hotkey: "T" to auto-release Fire Key in Aimlabs when user restarts their task
T::OnPressRestartKey
#HotIf

; Hotkeys: Toggle Fire Key for KovaaK's
#HotIf WinActive(WindowSelectorKovaaks)
; Hotkey: "Alt+F" to toggle Fire Key in KovaaK's
!F::OnPressToggleFireKey
; Hotkey: "T" to auto-release Fire Key in KovaaK's when user restarts their task
T::OnPressRestartKey
#HotIf

; Check window every 100ms for loss of focus
SetTimer(CheckWindow, 100)
CheckWindow() {
    global isHoldingFireKeyInAimlabs, isHoldingFireKeyInKovaaks
    local text := KeyNameFireWeapon . " was released because app lost focus"

    if (!WinActive(WindowSelectorAimlabs) && isHoldingFireKeyInAimlabs) {
        isHoldingFireKeyInAimlabs := false
        SendFireWeaponKeyUp()
        SendTrayTip("Aimlabs", text)
    }

    if (!WinActive(WindowSelectorKovaaks) && isHoldingFireKeyInKovaaks) {
        isHoldingFireKeyInKovaaks := false
        SendFireWeaponKeyUp()
        SendTrayTip("KovaaK's", text)
    }
}

; Automatically time out, releasing the fire key
; TODO Does this only run once after script is started, 120 seconds later?
SetTimer(AutoTimeout, -120000)
AutoTimeout() {
    global isHoldingFireKeyInAimlabs, isHoldingFireKeyInKovaaks
    local text := KeyNameFireWeapon . " was released because it automatically timed out"

    if (isHoldingFireKeyInAimlabs) {
        isHoldingFireKeyInAimlabs := false
        SendFireWeaponKeyUp()
        SendTrayTip("Aimlabs", text)
    }

    if (isHoldingFireKeyInKovaaks) {
        isHoldingFireKeyInKovaaks := false
        SendFireWeaponKeyUp()
        SendTrayTip("KovaaK's", text)
    }
}

; Ensure F is released when script exits
OnScriptExit(ExitReason, ExitCode) {
    global isHoldingFireKeyInAimlabs, isHoldingFireKeyInKovaaks
    local text := KeyNameFireWeapon . " was released because the script exited"

    if (isHoldingFireKeyInAimlabs || isHoldingFireKeyInKovaaks) {
        if (isHoldingFireKeyInAimlabs) {
            SendTrayTip("Aimlabs", text)
        }
        
        if (isHoldingFireKeyInKovaaks) {
            SendTrayTip("KovaaK's", text)
        }

        ResetScriptState()
    } else {
        SendTrayTip("Toggle Fire Key", "Nothing was held when script ended so nothing was released")
    }
}

OnExit(OnScriptExit)
