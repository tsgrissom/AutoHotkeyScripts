; --- VALORANT AHK SCRIPT ---
; Contains no hotkeys. A simple script which terminates unnecessary background processes for optimizing VALORANT latency.

#Requires AutoHotkey v2.0

pidPowerToys := ProcessClose("")
pidEpicGamesLauncher := ProcessClose("")
pidIntelDriverAssistant := ProcessClose("")
pidSunshine := ProcessClose("")

; "PowerToys",
;     "Epic Games Launcher",
;     "Intel Driver Assistant",
;     "Sunshine",
;     "Moonlight Buddy",
;     "Windows Game Mode",
;     "Windows Game Bar",
;     "Wallpaper Engine",
;     "Greenshot"

; --- Constants ---

TARGET_EXECUTABLES := [
    "Epic Games Launcher.exe"
]

; --- Functions ---

GetWindowSelectorForTargetExecutable(targetExecutable) {
    return "ahk_exe " targetExecutable
}

; --- Script State ---

targetsKilled := []

ResetScriptState() {
    global targetsKilled
    targetsKilled := []
}

for (index, value in TARGET_EXECUTABLES) {
        
}

