# TODO: Presave discord local windows settings to not request on startup

$processes = @(
    "EpicGamesLauncher",
    "Roblox",
    "Discord",
    "Steam",
    "upc",
    "msedge"
)

foreach ($proc in $processes) {
    $p = Get-Process -Name $proc -ErrorAction SilentlyContinue
    if ($p) {
        Write-Host "Killing process: $proc"
        Stop-Process -Name $proc -Force
    } else {
        Write-Host "Not running: $proc"
    }
}

$itemsToClean = @(
    # LocalAppData folders
    @{ Base = $env:LOCALAPPDATA; Path = "EpicGamesLauncher"; Type = "Folder" },
    @{ Base = $env:LOCALAPPDATA; Path = "Roblox"; Type = "Folder" },
    @{ Base = $env:LOCALAPPDATA; Path = "FortniteGame"; Type = "Folder" },
    @{ Base = $env:LOCALAPPDATA; Path = "Epic Games"; Type = "Folder" },
    @{ Base = $env:LOCALAPPDATA; Path = "Steam\htmlcache"; Type = "Folder" },
    @{ Base = $env:LOCALAPPDATA; Path = "Ubisoft Game Launcher"; Type = "Folder" },
    @{ Base = $env:LOCALAPPDATA; Path = "netease"; Type = "Folder" },
    @{ Base = $env:LOCALAPPDATA; Path = "Microsoft\Edge\User Data\Default\Cache"; Type = "Folder" },
    @{ Base = $env:LOCALAPPDATA; Path = "Microsoft\Edge\User Data\Default\Local Storage"; Type = "Folder" },
    @{ Base = $env:LOCALAPPDATA; Path = "Microsoft\Edge\User Data\Default\Session Storage"; Type = "Folder" },
    
    # LocalAppData files
    @{ Base = $env:LOCALAPPDATA; Path = "Microsoft\Edge\User Data\Default\History"; Type = "File" },
    @{ Base = $env:LOCALAPPDATA; Path = "Microsoft\Edge\User Data\Default\History-journal"; Type = "File" },
    @{ Base = $env:LOCALAPPDATA; Path = "Microsoft\Edge\User Data\Default\Visited Links"; Type = "File" },
    @{ Base = $env:LOCALAPPDATA; Path = "Microsoft\Edge\User Data\Default\Top Sites"; Type = "File" },
    @{ Base = $env:LOCALAPPDATA; Path = "Microsoft\Edge\User Data\Default\Top Sites-journal"; Type = "File" },
    @{ Base = $env:LOCALAPPDATA; Path = "Microsoft\Edge\User Data\Default\Shortcuts"; Type = "File" },
    @{ Base = $env:LOCALAPPDATA; Path = "Microsoft\Edge\User Data\Default\SharedStorage"; Type = "File" },
    @{ Base = $env:LOCALAPPDATA; Path = "Microsoft\Edge\User Data\Default\SharedStorage-wal"; Type = "File" },
    @{ Base = $env:LOCALAPPDATA; Path = "Microsoft\Edge\User Data\Default\Login Data"; Type = "File" },
    @{ Base = $env:LOCALAPPDATA; Path = "Microsoft\Edge\User Data\Default\Login Data-journal"; Type = "File" },
    @{ Base = $env:LOCALAPPDATA; Path = "Microsoft\Edge\User Data\Default\Login Data For Account"; Type = "File" },
    @{ Base = $env:LOCALAPPDATA; Path = "Microsoft\Edge\User Data\Default\Login Data For Account-journal"; Type = "File" },
    @{ Base = $env:LOCALAPPDATA; Path = "Microsoft\Edge\User Data\Default\Web Data"; Type = "File" },
    @{ Base = $env:LOCALAPPDATA; Path = "Microsoft\Edge\User Data\Default\Web Data-journal"; Type = "File" },
    @{ Base = $env:LOCALAPPDATA; Path = "Microsoft\Edge\User Data\Default\Bookmarks"; Type = "File" },
    @{ Base = $env:LOCALAPPDATA; Path = "Microsoft\Edge\User Data\Default\Favicons"; Type = "File" },
    @{ Base = $env:LOCALAPPDATA; Path = "Microsoft\Edge\User Data\Default\Favicons-journal"; Type = "File" },
    
    # AppData (Roaming) folders
    @{ Base = $env:APPDATA; Path = "discord\logs"; Type = "Folder" },
    @{ Base = $env:APPDATA; Path = "discord\Local Storage"; Type = "Folder" },
    @{ Base = $env:APPDATA; Path = "discord\Cache"; Type = "Folder" },
    @{ Base = $env:APPDATA; Path = "discord\WebStorage"; Type = "Folder" },
    @{ Base = $env:APPDATA; Path = "discord\Session Storage"; Type = "Folder" },
    @{ Base = $env:APPDATA; Path = "discord\IndexedDB"; Type = "Folder" },
    
    # AppData (Roaming) files
    @{ Base = $env:APPDATA; Path = "discord\settings.json"; Type = "File" },
    @{ Base = $env:APPDATA; Path = "discord\SharedStorage"; Type = "File" },
    @{ Base = $env:APPDATA; Path = "discord\Local State"; Type = "File" },
    
    # Steam folders
    @{ Base = "C:\Program Files (x86)\Steam"; Path = "config"; Type = "Folder" },
    @{ Base = "C:\Program Files (x86)\Steam"; Path = "logs"; Type = "Folder" }
)

foreach ($item in $itemsToClean) {
    $fullPath = Join-Path $item.Base $item.Path
    
    if (Test-Path $fullPath) {
        if ($item.Type -eq "Folder") {
            Remove-Item -Path $fullPath -Recurse -Force
            Write-Host "Deleted folder: $fullPath"
        } else {
            Remove-Item -Path $fullPath -Force
            Write-Host "Deleted file: $fullPath"
        }
    } else {
        Write-Host "Not found: $fullPath"
    }
}
