[CmdletBinding()]
param (
    [Parameter(Mandatory = $true)]
    [string]$Firstname,

    [Parameter(Mandatory = $true)]
    [string]$LastName,

    [string]$DnsDomainName = 'etc2103.onmicrosoft.com',

    [string]$UsageLocation = 'AT',

    # Retrieve the skuPartNumber using Get-MsolAccountSku | Format-List
    [string]$SkuPartNumber = 'SPB',

    # This array contains services, that should be disabled
    # Retrieve the plan names using Get-MsolAccountSku | Select-Object -ExpandProperty ServiceStatus
    [string[]]$DisabledPlans = @('SWAY', 'WHITEBOARD_PLAN1', 'KAIZALA_O365_P2')
)

#region calculated paramaters
$userPrincipalName = "$firstname.$lastname@$dnsDomainName"
$displayName = "$firstname $lastname"
$accountSkuDetails = Get-MsolAccountSku | 
    Where-Object { 
        $PSItem.SkuPartNumber -eq $skuPartNumber `
        -and 0 -lt ($PSItem.ActiveUnits - $PSItem.ConsumedUnits) 
    }
$accountSkuDetails = $accountSkuDetails | Select-Object -First 1
$accountSkuId = $accountSkuDetails.AccountSkuId   
$licenseOptions = New-MsolLicenseOptions `
    -AccountSkuId $accountSkuId `
    -DisabledPlans $disabledPlans
#endregion

#region process
$msolUser= New-MsolUser `
    -UserPrincipalName $userPrincipalName `
    -FirstName $firstname `
    -LastName $lastname `
    -DisplayName $displayName `
    -UsageLocation $usageLocation

Write-Verbose "User $userPrincipalName created with password $($msolUser.Password)"

    # Set-MsolUserPassword -ObjectId $msolUser.ObjectId -ForceChangePassword $true
if ($null -ne $msolUser) {
    Set-MsolUserLicense `
        -ObjectId $msolUser.ObjectId `
        -AddLicenses $accountSkuId `
        -LicenseOptions $licenseOptions
}
Write-Verbose "License $accountSkuId assigned to $userPrincipalName"
# Write-Output $msolUser
Write-Output @{
    UserPrincipalName = $userPrincipalName
    Password = $msolUser.Password
}
#endregion