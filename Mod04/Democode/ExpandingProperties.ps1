# Copy the contents of this file into the scripting pane of the ISE. 
# Highlight one line and press F8 to execute just that line. 

# 1
Get-AzureAdGroup -SearchString 'Sales' |
Add-AzureADGroupMember

# 2
Get-AzureAdGroup -SearchString 'Sales' |
Add-AzureADGroupMember -RefObjectId (
    Get-AzureADUser -SearchString 'Max')

# 3
Get-AzureAdUser | Get-Member

# 4
Help Add-AzureADGroupMember –ShowWindow

# 5
Get-AzureADUser -SearchString 'Max' | Select-Object -Property ObjectId

# 6
Get-AzureADUser -SearchString 'Max' | Select-Object -Property ObjectId | Get-Member

# 7
Get-AzureADUser -SearchString 'Max' | Select-Object -ExpandProperty ObjectId

# 8
Get-AzureADUser -SearchString 'Max' | Select-Object -ExpandProperty ObjectId | Get-Member

# 9
Get-AzureAdGroup -SearchString 'Sales' |
Add-AzureADGroupMember -RefObjectId (
    Get-AzureADUser -SearchString 'Max' |
    Select-Object -ExpandProperty ObjectId
)


