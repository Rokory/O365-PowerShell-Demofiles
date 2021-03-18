# 1
Connect-MsolService

# Get license members
Get-MsolAccountSku | Get-Member

# Get group members
Get-MsolGroup | Get-Member