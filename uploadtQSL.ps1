$LogDate = get-date -Format "yyyyMMdd"
$LogRootDir = "C:\tQSLLogs\"
$logdir = $LogRootDir+$LogDate
$tqslInstall = "C:\Program Files (x86)\TrustedQSL"
$UploadDir = (get-location).Path
$DefaultLocation = "QTH"
$BatchFile = C:\tQSLLogs\uploadtQSL.bat

if (!(Test-Path -Path $LogDir -PathType Container)) {
    New-Item -Path $LogRootDir -Name $logDate -ItemType Directory
}

$LogsToUpload = Get-ChildItem -Path $UploadDir | Where-Object {$_.Name -Like "*.adi"} | Select-Object -Property Name


foreach ($log in $LogsToUpload){
    $location = $null
    $path = $null
    write-host $log.name
    if ($Log.name -like "*@*") {
        $location = ($log.Name -split('@'))[1].substring(0,6)
           
    }
    else {
        $location = $DefaultLocation
    }
    $Path = $UploadDir+"\"+$log.Name
    Write-host $path $Location
    &"$BatchFile $tqslInstall $Location $Path $logdir"
}


