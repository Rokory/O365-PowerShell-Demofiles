# 1
Connect-MsolService

# 2
Get-MsolAccountSku | Measure-Object

# 3
Get-MsolUser | Measure-Object

# 4
(Get-MsolUser).WhenCreated |
New-TimeSpan -End (Get-Date) |
Measure-Object -Property TotalDays -Average |
Select-Object -expandproperty Average