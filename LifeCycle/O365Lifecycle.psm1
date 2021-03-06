<# Installation as module
    Copy this file to the folder 
    MyDocuments\WindowsPowerShell\ModulesO365LifeCycle
    or to %programfiles%\WindowsPowerShell\Modules\O365LifeCycle
    to install this as a module
#>
#Requires -Module MsOnline, ExchangeOnlineManagement
function New-O365User {
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
}

function Remove-O365User {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $true)]
        [string]
        $UserPrincipalName,
        [bool]
        $Removelicense = $true,
        [bool]
        $RemoveUser = $true
    )
    
    $exoMailbox = Get-EXOMailbox -UserPrincipalName $UserPrincipalName
    $msolUser = Get-MsolUser -UserPrincipalName $UserPrincipalName

    # Convert user mailbox to shared mailbox

    $exoMailbox | Set-Mailbox -Type Shared

    # Remove license

    if ($RemoveLicense) {
        Set-MsolUserLicense `
            -ObjectId $msolUser.ObjectId `
            -RemoveLicenses $msolUser.Licenses.AccountSkuId
    }

    #region Change SMTP address
    $primarySmtpAddress = $exoMailbox.PrimarySmtpAddress
    $emailAddresses = $exoMailbox.EmailAddresses # | 
        # Where-Object {
        #     $PSItem -notlike "*:$primarySmtpAddress"
        # }
    
    $newEmailAddresses = @()
    foreach ($emailAddress in $emailAddresses) {
        $colonPos = $emailAddress.IndexOf(':')
        $emailAddress = $emailAddress.Insert($colonPos + 1, 'Austritt.')
        $newEmailAddresses += $emailAddress
    }

    $exoMailbox | Set-Mailbox -EmailAddresses $newEmailAddresses
    #endregion

    # If working with AD Connect, this part musst be rewritten to work
    # against the local AD

    # Change UPN

    $newUserPrincipalName = "Austritt.$UserPrincipalName"
    Set-MsolUserPrincipalName `
        -ObjectId $msolUser.ObjectId `
        -NewUserPrincipalName $newUserPrincipalName



    # Block login

    Set-MsolUser -ObjectId $msolUser.ObjectId -BlockCredential $true

    # Remove user

    if ($RemoveUser) {
        Remove-MsolUser -ObjectId $msolUser.ObjectId -Force
    }
}