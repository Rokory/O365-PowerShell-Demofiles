#Assign a value to a variable and view its value in memory
$num1 = 5
$num1

$dnsDomain = 'etc2103.onmicrosoft.com'
$dnsDomain

Connect-MsolService
$msolGroup = Get-MsolGroup -SearchString 'IT'
$msolGroup

#Display variable contents within text
Write-Host "The DNS domain is $dnsDomain"

#Display properties of an object stored in a variable
$msolGroup | Format-List *
$msolGroup.GroupType
$msolGroup | Format-Table DisplayName, GroupType

#View variables in memory
Get-Variable

#View variable type
$num1.GetType()
$dnsDomain.GetType()
$msolGroup.GetType()
$msolGroup | Get-Member

#Forcing a specific variable type
$num2 = "5"
[Int]$num3 = "5"
$num2.GetType()
$num3.GetType()

$date1 = "March 5, 2019 11:45 PM"
[DateTime]$Date2 = "March 5, 2019 11:45 PM"
$date1.GetType()
$date2.GetType()

#When Windows PowerShell cannot convert the value to the
#correct type and error occurs
[Int]$num4 = "Text that can't convert"

#When adding dissimilar variable types, Windows PowerShell
#attempts to convert them to be the same based on the type
#of the first variable.

#String plus integer
$num2 + $num3

#Integer plus string
$num3 + $num2

#Integer plus string that cannot be converted
$num3 + $dnsDomain
