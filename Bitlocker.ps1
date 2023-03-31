#An example of a script block.  Was used in two instances of mass Bitlocker issues where going through each individual effected would of been time consuming.  
#This method allowed #End User Support team to premptively have recovery keys when interacting with users.  It also enabled us to enlist the help of individuals 
#with out access to get recovery keys to assist with recovery efforts

Invoke-Command -Computername <RemotePC> -ScriptBlock {(Get-BitLockerVolume -MountPoint C).KeyProtector }|Format-Table -Property PSComputerName, KeyProtectorId, RecoveryPassword -AutoSize
    