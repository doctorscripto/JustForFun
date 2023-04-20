# Function to get the Time in HexaDecimal
Function Get-NerdTime()
{
param(
[int]$Base=16,
[string]$Delim='-'
)
[int]$Pad=2+(6*([int]($Base -eq 2)))

# Get the Current date and time
$Now=Get-Date

# Access hours minutes and seconds, convert to Hex
$hour=[Convert]::tostring(($now.Hour),$Base).padleft($Pad,'0')
$Minute=[Convert]::tostring(($now.Minute),$Base).padleft($Pad,'0')
$Second=[Convert]::tostring(($now.Second),$Base).padleft($Pad,'0')

# Return as a single string
Return ("$Hour$Delim$Minute$Delim$Second")
}

