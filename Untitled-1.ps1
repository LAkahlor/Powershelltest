$hostnameFile = "C:\path\to\hostname\file.csv"
$hostnames = Import-Csv $hostnameFile | Select-Object -ExpandProperty Hostname

$scriptBlock = {
    # Your script block goes here
}

foreach ($hostname in $hostnames) {
    Invoke-Command -ComputerName $hostname -ScriptBlock $scriptBlock
}