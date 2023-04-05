#Work Avodiance buster.  Audio issues is one of the most reported issues from work at home users.
#This is a script to suddenly unmute an individuals mic or check it's working remotely
#This has been used to find individuals who are using mute buttons on their headset to pretend their mic is broken
# Get the audio device that represents the microphone
$mic = Get-WmiObject -Class Win32_SoundDevice | Where-Object {$_.Name -like '*microphone*'}

# Check if the microphone is muted
if ($mic.Mute) {
    # Unmute the microphone
    $mic.Mute = $false
    $mic.Put()
    Write-Host "Microphone unmuted."
} else {
    Write-Host "Microphone is already unmuted."
}