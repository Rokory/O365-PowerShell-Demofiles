# Copy the contents of this file into the scripting pane of the ISE. 
# Highlight one line and press F8 to execute just that line. 

Connect-MsolService
Connect-AzureAD

# 1
Get-AzureAdGroup | Get-AzureADGroupMember

# 2
Get-AzureAdGroup | Get-Member

# 3
Get-Help Get-AzureADGroupMember –ShowWindow