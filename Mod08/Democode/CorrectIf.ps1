$freeSpace = 1GB
$output = 'Free disk space is more than 10 GB'
if ($freeSpace -le 10GB) {
    $output = 'Free disk space is less than 10 GB'
}

if ($freeSpace -le 5GB) {
    $output = 'Free disk space is less than 5 GB'
}
Write-Host $output