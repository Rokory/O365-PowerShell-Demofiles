# Copy the contents of this file into the scripting pane of the ISE. 
# Highlight one line and press F8 to execute just that line. 

Connect-MsolService
Connect-AzureAd

# 1 
New-MsolGroup -DisplayName 'Helpdesk'
New-AzureADGroup -DisplayName 'Sales' -MailEnabled $false -SecurityEnabled $true -MailNickName 'Sales'

# 2
New-MsolUser -UserPrincipalName Jane.Doe@etc2103.onmicrosoft.com -DisplayName 'Jane Doe' -Department 'IT'

# 3
Add-MsolGroupMember `
    -GroupObjectId (
        Get-MsolGroup -SearchString 'Helpdesk' | 
        Select-Object -ExpandProperty ObjectId        
    ) `
    -GroupMemberType User `
    -GroupMemberObjectId (
        Get-MsolUser -UserPrincipalName Jane.Doe@etc2103.onmicrosoft.com | 
        Select-Object -ExpandProperty ObjectId
    )
Get-AzureAdGroup -SearchString 'Sales' |
Add-AzureADGroupMember -RefObjectId (
    Get-AzureADUser -SearchString 'Max' |
    Select-Object -ExpandProperty ObjectId
)

# 4
Get-MsolGroupMember -GroupObjectId (
    Get-MsolGroup -SearchString 'Helpdesk' | 
    Select-Object -ExpandProperty ObjectId
)
Get-AzureAdGroup -SearchString 'Sales' | Get-AzureADGroupMember

# 5
Get-AzureADUser -SearchString 'Max' | Get-AzureADUserMembership

New-AzureADGroup -DisplayName 'IT' -MailEnabled $false -SecurityEnabled $true -MailNickName 'IT'
Get-AzureAdGroup -SearchString 'IT' | Add-AzureADGroupMember -RefObjectId ( 
    Get-AzureADUser -Filter "Department eq 'IT'" |
    Select-Object -ExpandProperty ObjectId
) # Does not work

Get-AzureADUser -Filter "Department eq 'IT'" |
ForEach-Object {
    Get-AzureAdGroup -SearchString 'IT' | 
    Add-AzureADGroupMember -RefObjectId $PSItem.ObjectId
}
