#Set the value for a variable
$dnsDomain = "etc2103.com"

#Test whether a variable contains specific text
$dnsDomain.Contains("etc2103")
$dnsDomain.Contains(".onmicrosoft")

#Insert text into a variable value
#Note that the original variable value is not modified
#Output must be caputured to update the value
$dnsDomain.Insert(7,".onmicrosoft")
$dnsDomain
$dnsDomain=$dnsDomain.Insert(7,".onmicrosoft")
$dnsDomain

#Replace text in a variable value
$dnsDomain.Replace("etc","eo")

#Split a string into parts based on a separator
$dnsDomain.Split(".")
$dnsDomain.Split(".") | Select -Last 1

#Convert a string to upper or lowercase
#Parentheses are required for a method even when
#no value is specified
$dnsDomain.ToUpper()
$dnsDomain.ToLower()



