# 1
Get-MsolUser | Select-Object Displayname, WhenCreated

# 2
Get-MsolUser | 
Select-Object Displayname, WhenCreated | 
Sort-Object WhenCreated -Descending

# 3
Get-MsolUser | 
Select-Object Displayname, @{
    n='Age'
    e={
        New-TimeSpan -Start $PSItem.WhenCreated -End (Get-Date) |
        Select-Object -ExpandProperty Days  #
    }
} | 
Sort-Object Age -Descending