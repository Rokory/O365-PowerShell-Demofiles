# Copy the contents of this file into the scripting pane of the ISE. 
# Highlight one line and press F8 to execute just that line. 

Connect-MsolService
Connect-AzureAd

# create group
New-MsolGroup -DisplayName 'Helpdesk'
$name = 'Sales'
New-AzureADGroup -DisplayName $name -MailEnabled $true -SecurityEnabled $true -MailNickName $name

# create user
$dnsDomain = 'etc2103.onmicrosoft.com'
$firstName = 'Jane'
$lastName = 'Doe'
$userPrincipalName = "$firstname.$lastname@$dnsdomain"
$displayName = "$firstname $lastname"
$department = 'IT'
$msolUser = New-MsolUser -UserPrincipalName $userPrincipalName -DisplayName $displayName -Department $department

# 3
$msolGroup = Get-MsolGroup -SearchString 'Helpdesk' | Select-Object -First 1
# $msolUser = Get-MsolUser -UserPrincipalName $userPrincipalName
Add-MsolGroupMember `
    -GroupObjectId $msolGroup.ObjectId `
    -GroupMemberType User `
    -GroupMemberObjectId $msolUser.ObjectId
