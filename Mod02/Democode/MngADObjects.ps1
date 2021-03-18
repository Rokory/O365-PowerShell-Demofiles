# Copy the contents of this file into the scripting pane of the ISE. 
# Highlight one line and press F8 to execute just that line. 

Connect-ExchangeOnline

# 1
New-MailContact -Name JohnSmithcontact -DisplayName 'John Smith (Contoso.com)' -ExternalEmailAddress john.smith@contoso.com

# 2
Get-MailContact

# 3
Connect-MsolService
Connect-AzureAd

New-MsolUser -UserPrincipalName Max.Musterfrau@etc2103.onmicrosoft.com -Firstname Max -Lastname Musterfrau -DisplayName 'Max Musterfrau'
$PasswordProfile = New-Object -TypeName Microsoft.Open.AzureAD.Model.PasswordProfile
$PasswordProfile.Password = 'Pa55w.rd'
New-AzureADUser -DisplayName "Lara Schlecht" -PasswordProfile $PasswordProfile -UserPrincipalName 'Lara@etc2103.onmicrosoft.com' -AccountEnabled $true -MailNickName "Lara"

Set-MsolUserPassword -UserPrincipalName Max.Musterfrau@etc2103.onmicrosoft.com -NewPassword 'Pa55w.rd' -ForceChangePassword $true
Set-MsolUserPassword -UserPrincipalName Max.Musterfrau@etc2103.onmicrosoft.com -ForceChangePassword $true
Get-AzureADUser -SearchString 'Lara' | Set-AzureADUserPassword -Password (Read-Host -Prompt 'new password' -AsSecureString)

Set-MsolUser -UserPrincipalName Max.Musterfrau@etc2103.onmicrosoft.com -Department IT
Get-AzureADUser -SearchString 'Lara' | Set-AzureADUser -Department IT

# 4
Get-MsolUser -UserPrincipalName Max.Musterfrau@etc2103.onmicrosoft.com | Format-List
Get-AzureADUser -SearchString 'Lara' | Format-List

# 5
Set-MsolUserPrincipalName -UserPrincipalName Max.Musterfrau@etc2103.onmicrosoft.com -NewUserPrincipalName M.Musterfrau@etc2103.onmicrosoft.com
Get-AzureADUser -SearchString 'Lara' | Set-AzureADUser -UserPrincipalName 'L.Schlecht@etc2103.onmicrosoft.com'

# 6
Get-MsolGroup -SearchString 'Alle Benutzer'
Get-AzureAdGroup -SearchString 'Alle Benutzer'
