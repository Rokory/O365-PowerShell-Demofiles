[CmdletBinding()]
param (
    # Name of shared mailbox
    [Parameter(Mandatory)]
    [String]
    $Name,
    # Alias of shared mailbox
    [Parameter(Mandatory)]
    [string]
    $Alias,
    # SMTP address of shared mailbox; defaults to alias@defaultdomain
    [Parameter()]
    [string]
    $PrimarySmtpAddress,
    # Prefix for mail-enabled security group granted access to shared mailbox; defaults to 'MB'
    [Parameter()]
    [string]
    $MailEnabledSecurityGroupPrefix = 'MB'      
)

begin {
}

process {
    #region Create mail-enabled security group
    
    $distributionGroupParams = @{
        Name = "$mailEnabledSecurityGroupPrefix $Name"
        Alias = "$($mailEnabledSecurityGroupPrefix)_$($alias)"
    }
    $distributionGroup = Get-DistributionGroup `
        -Identity $distributionGroupParams.Alias -ErrorAction SilentlyContinue
    if ($distributionGroup) {
        Write-Warning `
            "Existing group $(
                $distributionGroup.DisplayName
            ) found. The group will be used for the shared mailbox."
    }    
    if (-not $distributionGroup) {
        Write-Verbose `
            "Creating mail-enabled security group $(
                $distributionGroupParams.Name
            )"
        $distributionGroup = `
            New-DistributionGroup @distributionGroupParams -Type Security
    }
    Write-Verbose "Hiding mail-enabled security group from address list."
    
    $distributionGroup | 
    Set-DistributionGroup -HiddenFromAddressListsEnabled $true
    
    #endregion Create mail-enabled security group

    #region Create shared mailbox

    $sharedMailboxParams = @{
        Alias = $Alias
        Name = $Name
    }

    if ($PrimarySmtpAddress) {
        $sharedMailboxParams.Add('PrimarySmtpAddress', $PrimarySmtpAddress)
    }

    $sharedMailbox = Get-Mailbox -Identity $sharedMailboxParams.Alias -ErrorAction SilentlyContinue
    if ($sharedMailbox) {
        Write-Warning `
            "Existing shared mailbox $(
                $sharedmailbox.Name
            ) found. This mailbox will be configured."
    }
    if (-not $sharedMailbox) {
        Write-Verbose "Creating shared mailbox $($sharedMailboxParams.Name)"
        $sharedMailbox = New-Mailbox @sharedMailboxParams -Shared
    }
    Write-Verbose `
        "Granting $($distributionGroup.Name) full access to shared mailbox."
    $sharedMailbox | Add-MailboxPermission `
        -AccessRights FullAccess `
        -InheritanceType All `
        -User $distributionGroup.Identity
    
    Write-Verbose "Enabling copy of sent messages to shared mailbox."
    $sharedMailbox | Set-Mailbox `
        -MessageCopyForSentAsEnabled $true `
        -MessageCopyForSendOnBehalfEnabled $true `
        -MessageCopyForSMTPClientSubmissionEnabled $true
    
    #endregion Create shared mailbox
    
}

end {
    
}
