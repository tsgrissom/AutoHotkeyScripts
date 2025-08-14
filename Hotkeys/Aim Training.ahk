#Requires AutoHotkey v2.0
#SingleInstance Force

; --- Constants ---

EXECUTABLE_NAMES := ["AimLab_tb.exe", "FPSAimTrainer-Win64-Shipping.exe"]
KEY_CODE_FIRE_WEAPON := "F"
KEY_CODE_RESTART_TASK := "T"
KEY_NAME_FIRE_WEAPON := "Fire Key (" KEY_CODE_FIRE_WEAPON ")"
KEY_NAME_RESTART_TASK := "Restart Key (" KEY_CODE_RESTART_TASK ")"

; --- Basic Functions ---

SendFireWeaponKeyDown() {
    Send "{" KEY_CODE_FIRE_WEAPON " down}"
}

SendFireWeaponKeyUp() {
    Send "{" KEY_CODE_FIRE_WEAPON " up}"
}

StartHoldingFireKey(appName) {
    SendFireWeaponKeyDown()
    SendTrayTip(appName, KEY_NAME_FIRE_WEAPON " is being held")
}

StopHoldingFireKey(appName) {
    SendFireWeaponKeyUp()
    SendTrayTip(appName, KEY_NAME_FIRE_WEAPON " was released")
}

GetRandomWindowSelector() {
    name := EXECUTABLE_NAMES[Random(1, EXECUTABLE_NAMES.Length)]
    return "ahk_exe " name
}

SendTrayTip(appName, message) {
    TrayTip(appName, message, 1)
}

; --- Script State ---

isHoldingFireKey := false
lastExecutableNameWhichHeldFireKey := ""
lastTimeHeldFireKey := A_Now

ResetScriptState() {
    global isHoldingFireKey, lastExecutableNameWhichHeldFireKey, lastTimeHeldFireKey
    isHoldingFireKey := false
    lastExecutableNameWhichHeldFireKey := ""
    lastTimeHeldFireKey := A_Now
    SendFireWeaponKeyUp()
}

; --- Event Handling ---

OnPressRestartKey() {
    global isHoldingFireKey, lastExecutableNameWhichHeldFireKey, lastTimeHeldFireKey
    text := KEY_NAME_FIRE_WEAPON " was released because the " KEY_NAME_RESTART_TASK " was pressed"

    if (isHoldingFireKey) {
        ResetScriptState
        SendTrayTip(lastExecutableNameWhichHeldFireKey, text)

        if (WinActive("ahk_exe " lastExecutableNameWhichHeldFireKey)) {
            Send KEY_CODE_RESTART_TASK
            Send "Click"
            SendFireWeaponKeyDown()
            isHoldingFireKey := true
        }
    }
}

OnPressToggleFireKey() {
    global isHoldingFireKey, lastExecutableNameWhichHeldFireKey, lastTimeHeldFireKey

    for (value in EXECUTABLE_NAMES) {
        selector := "ahk_exe " value

        if (!WinActive(selector)) {
            continue
        }
        
        ; Update global state
        isHoldingFireKey := !isHoldingFireKey
        lastExecutableNameWhichHeldFireKey := selector
        lastTimeHeldFireKey := A_Now

        ; Do start/stop of toggle
        if (isHoldingFireKey) {
            ; TODO Some safeguard on timing of this
            StartHoldingFireKey(value)
        } else {
            StopHoldingFireKey(value)
        }
    }
}

; --- On Script Start ---

; Check window every 100ms for loss of focus
SetTimer(CheckWindow, 100)
CheckWindow() {
    global isHoldingFireKey, lastExecutableNameWhichHeldFireKey, lastTimeHeldFireKey
    text := KEY_NAME_FIRE_WEAPON " was released because app lost focus"

    if (!WinActive(lastExecutableNameWhichHeldFireKey) && isHoldingFireKey) {
        isHoldingFireKey := false
        SendFireWeaponKeyUp()
        SendTrayTip(lastExecutableNameWhichHeldFireKey, text)
    }
}

; TODO Un-hardcode this timing
; Automatically time out, releasing the fire key
; TODO Does this only run once after script is started, 120 seconds later?
SetTimer(AutoTimeout, -120000)
AutoTimeout() {
    global isHoldingFireKey
    text := KEY_NAME_FIRE_WEAPON " was released because it automatically timed out"

    if (isHoldingFireKey) {
        isHoldingFireKey := false
        SendFireWeaponKeyUp()
        SendTrayTip(lastExecutableNameWhichHeldFireKey, text)
    }
}

; --- On Script Exit ---

; Ensure F is released when script exits
OnScriptExit(exitReason, exitCode) {
    global isHoldingFireKey
    text := KEY_NAME_FIRE_WEAPON " was released because the script exited"

    if (isHoldingFireKey) {
        SendTrayTip(lastExecutableNameWhichHeldFireKey, text)
        ResetScriptState()
    }
}

OnExit(OnScriptExit)

; --- Hotkeys ---

IsAimTrainerActive(*) {
    for , exe in EXECUTABLE_NAMES {
        if WinActive("ahk_exe " exe) {
            return true
        }
    }
    return false
}

#HotIf IsAimTrainerActive()
!F::OnPressToggleFireKey
T::OnPressRestartKey