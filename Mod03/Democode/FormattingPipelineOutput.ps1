# 1
Connect-MsolService

# 2
Get-MsolAccountSku

# 3
Get-MsolAccountSku | Format-List AccountSkuId, SkuPartNumber, ActiveUnits, ConsumedUnits

# 4
Get-MsolRole

# 5
Get-MsolRole | Format-Table Name, Description

# 6
Get-MsolUser

# 7
Get-MsolUser | Format-Wide -AutoSize