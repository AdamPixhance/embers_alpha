Set objShell = CreateObject("WScript.Shell")
Set objFSO = CreateObject("Scripting.FileSystemObject")
strScriptDir = objFSO.GetParentFolderName(WScript.ScriptFullName)
strBatchFile = strScriptDir & "\scripts\Embers0.1.bat"
If objFSO.FileExists(strBatchFile) Then
    objShell.Run """" & strBatchFile & """", 0, False
Else
    MsgBox "Error: Embers0.1.bat not found at " & strBatchFile, 16, "Embers0.1"
End If
