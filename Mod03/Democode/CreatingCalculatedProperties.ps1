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
    e={ '{0:n2}' -f `
        ((New-TimeSpan -Start $PSItem.WhenCreated -End (Get-Date) |
        Select-Object -ExpandProperty Days) / 365.25)
    }
} | 
Sort-Object Age -Descending