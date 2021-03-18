# Copy the contents of this file into the scripting pane of the ISE. 
# Highlight one line and press F8 to execute just that line. 

# 1
Get-AzureAdUser | ConvertTo-HTML

# 2
Get-AzureAdUser | ConvertTo-HTML | Out-File "$([Environment]::GetFolderPath('MyDocuments'))\users.html"

# 3
Get-AzureAdUser | ConvertTo-JSON > "$([Environment]::GetFolderPath('MyDocuments'))\users.json"

# 4
Get-AzureAdUser | ConvertTo-CSV | Out-File "$([Environment]::GetFolderPath('MyDocuments'))\users.csv"
# or run 
Get-AzureAdUser | Export-CSV "$([Environment]::GetFolderPath('MyDocuments'))\users.csv"

# 5
Notepad "$([Environment]::GetFolderPath('MyDocuments'))\users.csv"

# 6
Get-AzureAdUser | Export-CliXML "$([Environment]::GetFolderPath('MyDocuments'))\users.xml"

# 7
Notepad "$([Environment]::GetFolderPath('MyDocuments'))\users.xml"




