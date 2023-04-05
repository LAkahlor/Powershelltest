#this is a script to dump Service Now data into SQL Datalake/Database 
# ServiceNow credentials
$ServiceNowURL = "https://INSTANCE.service-now.com/"
#Service Now will either need a special user account for automation or a creditial key.

# SQL Server credentials
$SqlServerInstance = "INSTANCE"
$SqlDatabase = "DATABASE"
#Authentican dependant on enviorment and where the script is being run.

# ServiceNow query
$ServiceNowQuery = "table=incident&sysparm_query=sys_created_on>=javascript:gs.dateGenerate('2022-01-01','00:00:00')^ORDERBYDESCsys_created_on"

# ServiceNow REST API URL
$ServiceNowAPIURL = $ServiceNowURL + "api/now/table/incident?" + $ServiceNowQuery

# SQL Server connection string
$SqlConnectionString = "Server=$SqlServerInstance;Database=$SqlDatabase;User Id=$SqlUser;Password=$SqlPassword;"

# Import data from ServiceNow and insert into SQL Server table
try {
    # Import data from ServiceNow
    $ServiceNowData = Invoke-RestMethod -Method Get -Uri $ServiceNowAPIURL -Credential ($ServiceNowUser + ":" + $ServiceNowPassword)

    # Import data into SQL Server table
    $SqlConnection = New-Object System.Data.SqlClient.SqlConnection
    $SqlConnection.ConnectionString = $SqlConnectionString
    $SqlConnection.Open()
    $SqlCommand = $SqlConnection.CreateCommand()
    $SqlCommand.CommandText = "INSERT INTO dbo.Incidents (Number, Short_Description, Created_On, Created_By) VALUES (@Number, @Short_Description, @Created_On, @Created_By)"
    foreach ($Incident in $ServiceNowData.result) {
        $SqlCommand.Parameters.AddWithValue("@Number", $Incident.number)
        $SqlCommand.Parameters.AddWithValue("@Short_Description", $Incident.short_description)
        $SqlCommand.Parameters.AddWithValue("@Created_On", [datetime]$Incident.sys_created_on)
        $SqlCommand.Parameters.AddWithValue("@Created_By", $Incident.sys_created_by)
        $SqlCommand.ExecuteNonQuery()
        $SqlCommand.Parameters.Clear()
    }
    $SqlConnection.Close()

    Write-Host "Data imported successfully."
}
catch {
    Write-Error $_.Exception.Message
}