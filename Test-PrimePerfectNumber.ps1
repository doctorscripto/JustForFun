function test-isPrimeorPerfect
{
param([int]$value)
$DivisorArray = [System.Collections.ArrayList]@()
$PerfectNumber=$False
$SuccessfulDivision=0
$Divisor=1
do
{
if (([math]::Round(($Value/$Divisor))) -eq ($Value/$Divisor))
{
$SuccessfulDivision++
$DivisorArray.add($Divisor)
}
$Divisor++
}until($Divisor -ge $Value -or $SuccessfulDivision -ge 2)
$DivisorArray.Add($Divisor)
if ((($DivisorArray | Sort-Object -Unique | Measure-Object -Sum).sum) -eq $value)
{
$PerfectNumber = $True
}
IF ($SuccessfulDivision -ge 2)
{
Return [pscustomobject]@{Integer=$Value;IsPrime=$False;PerfectNumber=$PerfectNumber}
}
Else
{
Return [pscustomobject]@{Integer=$Value;IsPrime=$True;PerfectNumber=$PerfectNumber}
}
}