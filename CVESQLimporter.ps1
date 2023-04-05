#A test attempt at making a CVE/XML importer that is more efficent (currently can make Tables/DB's but doesn't insert data This script also creates a TABLE it doesn't insert into a current existing table It would have to be modified for that)

# Set up the connection to the SQL Server database
$serverName = "DESKTOP-N0Q3GJV\MSMYSQL"
$databaseName = "tsqltest"
$tableName = "cve"
$connectionString = "Server=$serverName;Database=$databaseName;Trusted_Connection=True;"
$conn = New-Object System.Data.SqlClient.SqlConnection($connectionString)
$conn.Open()

# Create a table to store the CVE data
$sqlCommand = "CREATE TABLE $tableName (id VARCHAR(50) PRIMARY KEY, summary VARCHAR(MAX), published VARCHAR(50), modified VARCHAR(50))"
$command = New-Object System.Data.SqlClient.SqlCommand($sqlCommand, $conn)
$command.ExecuteNonQuery()

# Parse the CVE XML file
$filePath = "C:\Users\lukek\Downloads\allitems.xml"
$xml = [xml](Get-Content $filePath)

# Loop through each CVE entry and insert it into the table
foreach ($entry in $xml.nvd.entry) {
    $id = $entry.id
    $summary = $entry.summary
    $published = $entry.published.'#text'
    $modified = $entry.modified.'#text'

    $sqlCommand = "INSERT INTO $tableName (id, summary, published, modified) VALUES ('$id', '$summary', '$published', '$modified')"
    $command = New-Object System.Data.SqlClient.SqlCommand($sqlCommand, $conn)
    $command.ExecuteNonQuery()
}

# Close the database connection
$conn.Close()