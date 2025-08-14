# Path to GUI AutoHotkey executable
$AhkExe = "C:\Program Files\AutoHotkey\v2\AutoHotkey.exe"

# Get directory where this PowerShell script is located
$ScriptDir = Split-Path -Parent $MyInvocation.MyCommand.Path

# Get all .ahk files in that directory, excluding those starting with "_"
$AhkFiles = Get-ChildItem -Path $ScriptDir -Filter *.ahk -File |
            Where-Object { -not ($_.BaseName.StartsWith("_")) }

foreach ($file in $AhkFiles) {
    Write-Host "Starting: " $file.Name
    Start-Process -FilePath $AhkExe -ArgumentList "`"$($file.FullName)`"" -WindowStyle Hidden
}
