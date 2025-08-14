#Requires AutoHotkey v2.0
#SingleInstance Force
#Warn

#Include Utilities.ahk

CountCommonSubdirectories := SubdirectoryIDMCommon.Length
GuiConfirmEmpty := Gui(, "Empty " CountCommonSubdirectories " /Downloads/ folders?")
GuiConfirmEmpty.OnEvent('Escape', OnClick_Cancel)

; Descriptive Text
LV := GuiConfirmEmpty.Add("ListView", "r20 w500", ["Name", "Path", "File #", "Size (MB)"])

for Name in SubdirectoryIDMCommon {
	SubdPath := Fn_GetDownloadSubdirectoryPath(Name)
	LV.Add(, Name, SubdPath, 0, 0)
}

LV.ModifyCol
LV.ModifyCol(3, 60)
LV.ModifyCol(4, 60)

TextDescribeAction := GuiConfirmEmpty.Add("Text",, "The above directories will be deleted")

; Button: Confirm
ButtonConfirm := GuiConfirmEmpty.Add("Button", "x10 w100 h25", "Confirm")
ButtonConfirm.OnEvent("Click", OnClick_Confirm)

ControlGetPos(&ButtonConfirmXPos, &ButtonConfirmYPos, &ButtonConfirmWidth, &ButtonConfirmHeight, ButtonConfirm.Hwnd, GuiConfirmEmpty.Hwnd)

; Button: Cancel
ButtonCancelXPos := ButtonConfirmXPos + (ButtonConfirmWidth * 1.1)
ButtonCancelPos  := "x" . ButtonCancelXPos . " y" . ButtonConfirmYPos 
ButtonCancel := GuiConfirmEmpty.Add("Button", ButtonCancelPos . " w100 h25", "Cancel")
ButtonCancel.OnEvent("Click", OnClick_Cancel)

OnClick_Confirm(*) {
	Fn_EmptySomeDownloadSubdirectories(true, SubdirectoryIDMCommon)
}

OnClick_Cancel(*) {
	ExitApp()
}

GuiConfirmEmpty.Show("w525")