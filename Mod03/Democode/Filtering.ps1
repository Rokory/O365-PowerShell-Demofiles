# Copy the contents of this file into the scripting pane of the ISE. 
# Highlight one line and press F8 to execute just that line. 

Connect-AzureAD

# 1
Get-AzureAdGroup | Where MailEnabled -eq $true
Get-AzureAdGroup | Where MailEnabled

# 2
Get-AzureAdUser | Where-Object –FilterScript { $PSItem.Department -like 'Op*' } | Select-Object -Property Displayname, Userprincipalname, Department

# 3
Get-AzureAdUser | Where-Object –FilterScript { $PSItem.Department -eq 'IT' -and $PSItem.Surname -like 'M*'  } | Select-Object -Property Surname, Department, Userprincipalname

# 4
Get-Verb | Where { $_.Verb –like 'c*' } | fw



