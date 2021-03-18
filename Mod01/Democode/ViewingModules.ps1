# Copy the contents of this file into the scripting pane of the ISE. 
# Highlight one line and press F8 to execute just that line. 

# 1 
Get-Module
Install-Module MSOnline
Find-Module *Exchange*
Install-Module ExchangeOnlineManagement
Find-Module *AzureAd*
Install-Module AzureADPreview
Connect-MsolService

# 2
Get-MsolUser -SearchString 'Lara'

# 3
Get-Module

# 4
Get-Module -ListAvailable

# 5
Import-Module AzureADPreview

# 6
Get-Module


