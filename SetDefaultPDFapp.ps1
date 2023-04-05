$defaultPDFApp = "C:\Program Files\Adobe\Acrobat Reader DC\Reader\AcroRd32.exe" # replace with the path to your preferred PDF app
$fileType = ".pdf"

# Set the default PDF app for the current user
New-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\FileExts\$fileType\UserChoice" -Name "ProgId" -Value "Applications\$defaultPDFApp" -Force

# Set the default PDF app for all users
New-ItemProperty -Path "HKLM:\SOFTWARE\Classes\$fileType\OpenWithProgids" -Name "Applications\$defaultPDFApp" -Value "" -Force

# Refresh the icon cache
stop-process -name explorer