# Set variables for the server, database, and trusted connection
$serverName = "DESKTOP-N0Q3GJV\MSMYSQL"
$databaseName = "testdb"
$trustedConnection = $true

# Construct the connection string
$connectionString = "Server=$serverName;Database=$databaseName;Trusted_Connection=$trustedConnection;"

# Create a new SQL connection object
$sqlConnection = New-Object System.Data.SqlClient.SqlConnection($connectionString)

# Try to open the connection
try {
    $sqlConnection.Open()
    Write-Host "Connection to SQL server successful!"
}
catch {
    Write-Host "Connection to SQL server failed: $_.Exception.Message"
}
finally {
    # Close the connection
    $sqlConnection.Close()
}