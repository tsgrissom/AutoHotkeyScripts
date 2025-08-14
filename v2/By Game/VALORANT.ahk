; --- VALORANT AHK SCRIPT ---
; Contains no hotkeys. A simple script which terminates unnecessary background processes for optimizing VALORANT latency.

#Requires AutoHotkey v2.0

pidPowerToys := ProcessClose("")
pidEpicGamesLauncher := ProcessClose("")
pidIntelDriverAssistant := ProcessClose("")
pidSunshine := ProcessClose("")

TargetProcesses := [
    "PowerToys",
    "Epic Games Launcher",
    "Intel Driver Assistant",
    "Sunshine",
    "Moonlight Buddy",
    "Windows Game Mode",
    "Windows Game Bar",
    "Wallpaper Engine"
]