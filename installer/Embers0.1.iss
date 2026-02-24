#define MyAppName "Embers0.1"
#define MyAppPublisher "Embers0.1"
#ifndef MyAppVersion
  #define MyAppVersion "1.0.0"
#endif

[Setup]
AppId={{C9C84D2A-C2F1-4D00-8A0C-13A5F2E05B9A}
AppName={#MyAppName}
AppVersion={#MyAppVersion}
AppPublisher={#MyAppPublisher}
DefaultDirName={localappdata}\Programs\Embers0.1
DefaultGroupName={#MyAppName}
OutputDir=..\dist-installer
OutputBaseFilename=Embers0.1-Setup-{#MyAppVersion}
Compression=lzma
SolidCompression=yes
WizardStyle=modern
PrivilegesRequired=lowest

[Languages]
Name: "english"; MessagesFile: "compiler:Default.isl"

[Tasks]
Name: "desktopicon"; Description: "Create a desktop shortcut"; GroupDescription: "Additional icons:"; Flags: unchecked

[Files]
Source: "..\dist\Embers0.1\*"; DestDir: "{app}"; Flags: ignoreversion recursesubdirs createallsubdirs

[Icons]
Name: "{group}\{#MyAppName}"; Filename: "{app}\Embers0.1.exe"
Name: "{autodesktop}\{#MyAppName}"; Filename: "{app}\Embers0.1.exe"; Tasks: desktopicon

[Run]
Filename: "{app}\Embers0.1.exe"; Description: "Launch Embers0.1"; Flags: nowait postinstall skipifsilent
