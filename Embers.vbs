Set objShell = CreateObject("WScript.Shell")
Set objFSO = CreateObject("Scripting.FileSystemObject")
strScriptDir = objFSO.GetParentFolderName(WScript.ScriptFullName)
strBatchFile = strScriptDir & "\scripts\Embers.bat"
If objFSO.FileExists(strBatchFile) Then
    objShell.Run """" & strBatchFile & """", 0, False
Else
    MsgBox "Error: Embers.bat not found at " & strBatchFile, 16, "Embers"
End If
