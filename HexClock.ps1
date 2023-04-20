# Define an array of 16 Hexadecimal characters and two separators
[array]$HexArray=@(' ') *18

$HexArray[0]=@'
 000000 
00   000
00  0 00
00 00 00
00 0  00
000   00
 000000
'@

$HexArray[1]=@'
   11   
 1111   
11 11   
   11   
   11   
   11   
11111111
'@

$HexArray[2]=@'
  2222  
222  222
      22
   2222 
 222    
22      
22222222
'@

$HexArray[3]=@'
  3333  
333  333
      33
   3333 
      33
333  333
  3333  
'@

$HexArray[4]=@'
   444  
  4 44  
 4  44  
4444444 
    44  
    44  
    44  
'@

$HexArray[5]=@'
55555555
55      
55      
5555555 
      55
      55
5555555 
'@

$HexArray[6]=@'
 666666 
66    66
66      
6666666 
66    66
66    66
 666666 
'@

$HexArray[7]=@'
7777777 
    77  
   77   
  77    
  77    
  77    
  77    
'@

$HexArray[8]=@'
 888888 
88    88
88    88
 888888 
88    88
88    88
 888888 
'@

$HexArray[9]=@'
 999999 
99    99
99    99
 9999999
      99
99    99
 999999 
'@

$HexArray[10]=@'
   AA   
  AAAA  
 AA  AA 
AAAAAAAA
AA    AA
AA    AA
AA    AA
'@

$HexArray[11]=@'
BBBBBBB 
BB    BB
BB    BB
BBBBBBB 
BB    BB
BB    BB
BBBBBBB 
'@

$HexArray[12]=@'
 CCCCCC 
CC    CC
CC      
CC      
CC      
CC    CC
 CCCCCC 
'@

$HexArray[13]=@'
DDDDDDD 
DD    DD
DD    DD
DD    DD
DD    DD
DD    DD
DDDDDDD 
'@

$HexArray[14]=@'
EEEEEEEE
EE      
EE      
EEEEE   
EE      
EE      
EEEEEEEE
'@

$HexArray[15]=@'
FFFFFFFF
FF      
FF      
FFFFF   
FF      
FF      
FF      
'@

$HexArray[16]=@'
      //
     // 
    //  
   //   
  //    
 //     
//      
'@

$HexArray[17]=@'
        
        
        
  ####  
        
        
        
'@

# Function to get the Time in HexaDecimal
Function Get-HexTime()
{

# Get the Current date and time
$Now=Get-Date

# Access hours minutes and seconds, convert to Hex
$hour=[Convert]::tostring(($now.Hour),16).padleft(2,'0')
$Minute=[Convert]::tostring(($now.Minute),16).padleft(2,'0')
$Second=[Convert]::tostring(($now.Second),16).padleft(2,'0')

# Return as a single string
Return ("$Hour/$Minute/$Second")
}

# Clear the screen
Clear-Host
$Position=$host.ui.RawUI.CursorPosition

# Define out starting position
$Position.Y=3
$Position.X=4

do {
    # Move to the Start
    $host.ui.RawUI.CursorPosition=$Position

    $CurrentPosition=$Position
    
    # Grab the current time
    do
    {
        $HexTime=Get-HexTime
    # Don't go forward until Time has changed
    } Until ($Hextime -ne $LastHexTime)
            
    # Step through the various digits in the Time String
    For ($Count=0; $Count -lt ($HexTime.Length); $Count++)
    {

    # Obtain Array character based upon match
    $Character=($HexArray[('0123456789abcdef/-' | Select-String -pattern ($HexTime[$Count])).Matches.Index])
    
    # Split the Here-String when you see the Linefeed (ASCII 10)
    $CharacterArray=$Character.split([char][byte]10)

    # Capture and store current Row and Column
    $CurrentRow=$CurrentPosition.Y
    $Column=$CurrentPosition.X

        # Step through the various rows in the Here-String
        For ($Row=0; $Row -lt 7; $Row++)
        {
    
        # Set the Cursor Position
        $host.UI.RawUI.CursorPosition=$CurrentPosition
        
        # Draw the row for the Character
        $CharacterArray[$Row]
        
        # Move up to the Next row
        $CurrentPosition.Y=$CurrentPosition.Y + 1
            
        }

    # Increase the Counter for the Column
    $CurrentPosition.X=$CurrentPosition.X + 10
    
    # Reset the Row back to the start
    $CurrentPosition.Y = $CurrentRow
    
    }
    
    # Track the Time to note when it changes
    $LastHexTime = $Hextime
    
    # Make a tic and bug your co-worker ;)
    [console]::beep(1000,5)

} until ($False)
