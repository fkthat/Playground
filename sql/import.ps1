$dt = "${env:USERPROFILE}\Programs\dt1.8.3\drop\dt.exe" 
$ep = 'https://localhost:8081/'
$key= 'C2y6yDjf5/R+ob0N8A7Cgv30VRDJIWEHLM+4QDU5DE2nQ9nDuVTqobD4b8mGGyPMbIZnqyMsEcaGQy67XIw/Jw=='
$db = 'Northwind'

& $dt `
  /s:JsonFile `
  /s.Files:$PSScriptRoot\Orders.json `
  /t:DocumentDB `
  /t.ConnectionString:AccountEndpoint=$ep`;AccountKey=$key`;Database=$db `
  /t.Collection:Orders
