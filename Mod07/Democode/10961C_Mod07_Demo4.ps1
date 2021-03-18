#Place items into an array
$groups = "Helpdesk","Sales","IT"
$users = Get-MsolUser

#View the items in an array
$groups
$users
$users.count
$users[2]

#View propterties and methods for array items
$groups | Get-Member
$users | Get-Member
$users[2].UserPrincipalName

#Add an item to an array
$groups += "London Users"
$groups

#Create an ArrayList
[System.Collections.ArrayList]$usersList = Get-MsolUser
$usersList.IsFixedSize

#Remove an item from an ArrayList
$usersList.count
$usersList[5]
$usersList.RemoveAt(5)
$usersList.count
$usersList[5]
