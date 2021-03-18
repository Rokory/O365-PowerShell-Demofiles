# 1
Connect-MsolService

# 2
Get-MsolUser | Sort-Object isLicensed

# 3
Get-MsolUser | Sort-Object isLicensed -Descending

# 4
Install-Module ExchangeOnlineManagement
Connect-ExchangeOnline

# 5
Search-UnifiedAuditLog -StartDate 3/14/21 -EndDate 3/16/21 | 
Sort-Object CreationDate -Descending | Select-Object -First 10

# 6
Search-UnifiedAuditLog -StartDate 3/14/21 -EndDate 3/16/21 | 
Sort-Object CreationDate | Select-Object -First 10

# 7
Get-MsolUser | Sort-Object Displayname | Format-Wide
