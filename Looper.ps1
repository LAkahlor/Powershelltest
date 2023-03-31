#A way to take a list of Hostnames and run a particular script for each individual Hostname.
$Computers = Import-Csv -Path C:\Path\To\CSV\File.csv #Basic setting of variables. 
#The needed Loop
ForEach ($Computer in $Computers) {
    Invoke-Command -ComputerName $Computer.Hostname -ScriptBlock {
        # Your script block goes here  Can be used to collect/and export Data or maniuplate each end point in some cpacity.s
    }
}