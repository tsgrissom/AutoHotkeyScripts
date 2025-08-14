#Requires AutoHotkey v2.0

DirectoryDownloads      := "C:\Users\" . A_UserName . "\Downloads\"
SubdirectoryIDMCommon   := ["Compressed", "Documents", "Programs"]
SubdirectoryIDMAll      := ["Compressed", "Documents", "General", "Music", "Programs", "Videos"]
PathWindowsRecycleSound := A_WinDir . "\Media\Windows Recycle.wav"

Fn_EmptyDirectoryByDeleteAndRecreate(Path, Recursive := true, PlaySound := true) {
	DirDelete(Path, Recursive)
	DirCreate(Path)
	
	if PlaySound {
		SoundPlay(PathWindowsRecycleSound)
	}
}

Fn_GetDownloadSubdirectoryPath(Subdirectory) {
	return DirectoryDownloads . Subdirectory
}

Fn_GetAllDownloadSubdirectoryPaths() {
	; TODO
}

Fn_EmptySomeDownloadSubdirectories(Recursive := true, Subdirectories*) {
	DoAll := false
	
	for Index,Arr in Subdirectories {
		Value := StrLower(Arr[Index])
		if Value == "all" || Value == "general" {
			DoAll := true
		}
	}
	
	if DoAll {
		Fn_EmptyAllDownloadSubdirectories()
		return
	}
	
	for Index,Arr in Subdirectories {
		Path := Fn_GetDownloadSubdirectoryPath(Arr[Index])
		Fn_EmptyDirectoryByDeleteAndRecreate(Path, Recursive)
	}
}

Fn_EmptyAllDownloadSubdirectories() {
	MsgBox "All /Downloads/ subdirectories emptied"
	SoundPlay(PathWindowsRecycleSound) ; Remove once it relies on a function impl
	; TODO
}

Fn_EmptySpecificDownloadSubdirectory(Subdirectory := "General", Recursive := true) {
	Path := Fn_GetDownloadSubdirectoryPath(Subdirectory)
	if not DirExist(Path) {
		MsgBox("Dir " Path " does not exist")
		return
	}
	
	Fn_EmptyDirectoryByDeleteAndRecreate(Path)
}