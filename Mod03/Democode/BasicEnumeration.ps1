# Copy the contents of this file into the scripting pane of the ISE. 
# Highlight one line and press F8 to execute just that line. 

Connect-AzureAD

# 1
Get-AzureADUser | ForEach DisplayName

# 2
Get-AzureADUser | Where Department –eq 'Sales' | ForEach Remove-AzureAdUser

