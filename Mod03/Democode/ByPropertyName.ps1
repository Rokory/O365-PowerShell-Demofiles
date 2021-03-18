# Open this file in the ISE. Highlight one line and press F8 to
# execute just that line. 

# 1
Connect-MsolService
$path = 'C:\Users\RomanKorecky\OneDrive - Easy On\Seminarunterlagen\Microsoft\365\PowerShell für 365\10961B Labfiles\Mod03\Democode\Users1.csv'

# 2
Import-CSV $path
# Notice that the CSV columns become properties, and
# the rows become individual objects

# 3
Help New-MsolUser –ShowWindow
# Notice that the parameters correspond to Active Directory
# attributes. Also notice that most parameters accept
# pipeline input ByPropertyName

# 4
Import-CSV $path | New-MsolUser
# This command would work, but does not represent a real-world
# scenario. In a real organization, the people providing the
# CSV file might not get the format correct.

# 5
Import-CSV $path | Remove-MsolUser

# 6
$path = 'C:\Users\RomanKorecky\OneDrive - Easy On\Seminarunterlagen\Microsoft\365\PowerShell für 365\10961B Labfiles\Mod03\Democode\Users2.csv'
Import-CSV $path
# This is a more real-world input file. The samAccountName
# property is missing. Perhaps a well-meaning person 
# did not understand what it was for, so they removed it.
# We need that to make the command work.

# 7
Import-CSV $path | 
Select-Object –Property *,@{n='Userprincipalname';e={"$($_.Name)@etc2103.onmicrosoft.com"}}, @{n='Displayname'; e={$_.Name}} | 
New-MsolUser
# This command will work. We modify the objects in the
# pipeline to correspond with the parameter names we need.

# 6
Get-MsolUser
# Point out that the new user accounts exist.
