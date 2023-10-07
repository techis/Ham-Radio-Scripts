$LogDate = get-date -Format "yyyyMMdd"
$LogRootDir = "C:\tQSLLogs\"
$logdir = $LogRootDir+$LogDate
$tqslInstall = "C:\Program Files (x86)\TrustedQSL"
$UploadDir = (get-location).Path
$DefaultLocation = "QTH"
$BatchFile = "C:\tQSLLogs\uploadtQSL.bat"
$processedDir = $LogDir+"\Processed\"

if (!(Test-Path -Path $LogDir -PathType Container)) {
    Write-host "Creating $LogRootDir\$logDate"
    New-Item -Path $LogRootDir -Name $logDate -ItemType Directory
}
if (!(Test-Path -Path $processedDir -PathType Container)) {
    Write-host "Creating $logDir\Processed"
    New-Item -Path $logdir -Name "Processed" -ItemType Directory
}


$LogsToUpload = Get-ChildItem -Path $UploadDir | Where-Object {$_.Name -Like "*.adi"} | Select-Object -Property Name


foreach ($log in $LogsToUpload){
    $location = $null
    $path = $null
    write-host "Found $($log.name)"
    if ($Log.name -like "*@*") {
        $location = ($log.Name -split('@'))[1].substring(0,6)
           
    }
    else {
        $location = $DefaultLocation
    }
    $Path = $UploadDir+"\"+$log.Name

    Write-host "Uploading $($log.name)"

    &"$BatchFile" $tqslInstall $Location $Path $logdir

    Write-host "Moving $($log.name) to $ProcessedDir"
    Move-Item -Path $path -Destination "$ProcessedDir\$($log.name)"
}


