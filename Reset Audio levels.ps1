#Reset Audio device Endpoint
Invoke-Command -ComputerName {computer} -ScriptBlock { Write-EventLog -Logname Application -Source 'Change Sound Device' -EntryType Information -EventID 1 -Message 'This is the default sound device trigger' }
#Adjust Audio levels 
# Get the current volume object
$vol = Get-AudioDevice -PlaybackVolume

# Get the current volume level
$currentLevel = $vol.Volume

# Set the new volume level
$newLevel = $currentLevel + 5

# Check if the new volume level is within the valid range
if ($newLevel -lt $vol.VolumeMin) {
  $newLevel = $vol.VolumeMin
} elseif ($newLevel -gt $vol.VolumeMax) {
  $newLevel = $vol.VolumeMax
}

# Set the new volume level
$vol.Volume = $newLevel

# Commit the changes
$vol.Commit()