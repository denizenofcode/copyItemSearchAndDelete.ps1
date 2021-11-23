# This Script Deletes a target file from public desktop and all users' desktops.  It also places a file on the public desktop.
# USAGE: RUN/F5
# WARNING:
#   (0) Disable unused functions at the bottom of the script before running. 
#   (1) Set & Verify FileName for "Remove-All-Users-RDP" & "Remove-Search-And-Destroy-RDP" Functions.  
#   (2) Verify file/path for file from "Copy-New-RDP" function.


# TODO:
# Only write-host that items have been deleted if confirmed that they were.


function Copy-New-RDP {
    Copy-Item "\\Server\remote.rdp" -Destination "C:\Users\Public\Desktop\remote.rdp" -PassThru
}

function Remove-All-Users-RDP 
{
    $FileName = "C:\Users\Public\Desktop\remote.rdp"
    if (Test-Path $FileName) {
        Remove-Item $FileName
        write-Host "$FileName has been deleted"
    }
    else {
        Write-Host "$FileName doesn't exist"
    }
}

function Remove-Search-And-Destroy-RDP
{   $FileName = "remote.rdp" # EXACT Name of File to destroy
    Get-ChildItem -Path "C:\Users*" -include $FileName -filter *.rdp -Recurse | Remove-Item -Force #-WhatIf
    Write-Host "$FileName has been deleted"
}

Copy-New-RDP
Remove-All-Users-RDP
Remove-Search-And-Destroy-RDP

