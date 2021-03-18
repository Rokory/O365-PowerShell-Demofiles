# 1
Connect-MsolService

# 2
Get-MsolUser | Select-Object Displayname, WhenCreated | Sort-Object WhenCreated

# 3
Get-Date | Select-Object DayOfWeek

# 4
Get-MsolUser | Group-Object UserType
Get-MsolUser | Format-Table -GroupBy UserType