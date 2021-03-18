# Copy the contents of this file into the scripting pane of the ISE. 
# Highlight one line and press F8 to execute just that line. 

# Conenct to Exchange Online
Connect-ExchangeOnline

# 1: Create new contact
New-MailContact `
    -Name JohnSnowContact `
    -DisplayName 'John Snow (Contoso.com)' `
    -ExternalEmailAddress john.snow@contoso.com

# 2: View mail contact
Get-MailContact

# 3: Connect to Azure AD
Connect-MsolService
Import-Module AzureAD
Connect-AzureAd

# create user
New-MsolUser `
    -UserPrincipalName Max.Musterfrau@etc2103.onmicrosoft.com `
    -Firstname Max `
    -Lastname Musterfrau `
    -DisplayName 'Max Musterfrau'
$PasswordProfile = New-Object -TypeName Microsoft.Open.AzureAD.Model.PasswordProfile
$PasswordProfile.Password = 'Pa55w.rd'
Set-MsolUserPassword -UserPrincipalName Max.Musterfrau@etc2103.onmicrosoft.com -NewPassword 'Pa55w.rd' -ForceChangePassword $true
Set-MsolUserPassword -UserPrincipalName Max.Musterfrau@etc2103.onmicrosoft.com -ForceChangePassword $true

New-AzureADUser `
    -DisplayName "Lara Schlecht" `
    -PasswordProfile $PasswordProfile `
    -UserPrincipalName 'Lara@etc2103.onmicrosoft.com' `
    -AccountEnabled $true `
    -MailNickName "Lara"
Get-AzureADUser -SearchString 'Lara' | 
Set-AzureADUserPassword -Password (
    Read-Host -Prompt 'new password' -AsSecureString
)

# Change property

Set-MsolUser -UserPrincipalName Max.Musterfrau@etc2103.onmicrosoft.com -Department IT
Get-AzureADUser -SearchString 'Lara' | Set-AzureADUser -Department IT

# Get user properties
Get-MsolUser -UserPrincipalName Max.Musterfrau@etc2103.onmicrosoft.com | Format-List
Get-AzureADUser -SearchString 'Lara' | Format-List

# Change user principal name
Set-MsolUserPrincipalName -UserPrincipalName Max.Musterfrau@etc2103.onmicrosoft.com -NewUserPrincipalName Mx.Musterfrau@etc2103.onmicrosoft.com
Get-AzureADUser -SearchString 'Lara' | Set-AzureADUser -UserPrincipalName 'L.Schlecht@etc2103.onmicrosoft.com'

# Retrieve groups
Get-MsolGroup -SearchString 'Alle Benutzer'
Get-AzureAdGroup -SearchString 'Alle Benutzer'
