#Requires AutoHotkey v2.0
#SingleInstance Force
#Warn

#Include "Utilities.ahk"

; Initialize GUI
GuiEmptyDownloads := Gui(, "Empty Downloads")
GuiEmptyMultiple  := Gui(, "Empty Multiple")

; Escape flow
GuiEmptyDownloads.OnEvent('Escape', (*) => ExitApp())
GuiEmptyMultiple.OnEvent('Escape', ShowGuiEmptyDownloads)

; Show GUI functions
ShowGuiEmptyDownloads(*) {
	GuiEmptyDownloads.Show("w300")
}

; Button: Empty multiple
ButtonBatchDelete := GuiEmptyDownloads.Add("Button", "y10 w150 h25", "Clear Multiple")
ButtonBatchDelete.OnEvent("Click", OnClick_EmptyMultiple)

OnClick_EmptyMultiple(*) {
	; TODO
	MsgBox "Empty multiple!"
}

; Button: Empty all
ButtonEmptyAll := GuiEmptyDownloads.Add("Button", "y10 w150 h25", "Clear All")
ButtonEmptyAll.OnEvent("Click", OnClick_EmptyAll)
OnClick_EmptyAll(*) {
	; TODO
	MsgBox "Empty all!"
}

; Button: Empty /Downloads/Compressed/
TextEmptyCompressed   := GuiEmptyDownloads.Add("Text", "x10 y45 w150", "Empty /Compressed/")
ButtonEmptyCompressed := GuiEmptyDownloads.Add("Button", "x120 y40 w100", "Perform")
ButtonEmptyCompressed.OnEvent("Click", OnClick_EmptyCompressed)
OnClick_EmptyCompressed(*) { ; Asterisk ignores callback params, they are not needed
	Fn_EmptySpecificDownloadSubdirectory("Compressed")
}

; Button: Empty /Downloads/Documents/
TextEmptyDocuments   := GuiEmptyDownloads.Add("Text", "x10 y75 w150", "Empty /Documents/")
ButtonEmptyDocuments := GuiEmptyDownloads.Add("Button", "x120 y70 w100", "Perform")
ButtonEmptyDocuments.OnEvent("Click", OnClick_EmptyDocuments)
OnClick_EmptyDocuments(*) {
	Fn_EmptySpecificDownloadSubdirectory("Documents")
}

; Button: Empty /Downloads/Programs/
TextEmptyPrograms   := GuiEmptyDownloads.Add("Text", "x10 y105 w150", "Empty /Programs/")
ButtonEmptyPrograms := GuiEmptyDownloads.Add("Button", "x120 y100 w100", "Perform")
ButtonEmptyPrograms.OnEvent("Click", OnClick_EmptyPrograms)
OnClick_EmptyPrograms(*) {
	Fn_EmptySpecificDownloadSubdirectory("Programs")
}

; Show first GUI when done with setup
ShowGuiEmptyDownloads()