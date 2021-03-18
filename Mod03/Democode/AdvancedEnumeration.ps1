# Copy the contents of this file into the scripting pane of the ISE. 
# Highlight one line and press F8 to execute just that line. 

Connect-AzureAd

# 1
Get-AzureADUser -Filter "Department eq 'IT'" |
ForEach-Object {
    Get-AzureAdGroup -SearchString 'IT' | 
    Add-AzureADGroupMember -RefObjectId $PSItem.ObjectId
}

$azureAdGroup = Get-AzureAdGroup -SearchString 'Sales'
Get-AzureADUser -Filter "Department eq 'Sales'" |
ForEach-Object {
    $azureAdGroup | 
    Add-AzureADGroupMember -RefObjectId $PSItem.ObjectId
}

