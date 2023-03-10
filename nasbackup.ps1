# Auto-Backup to Sharepoint Online
# Autor: Francisco Orozco

# Limite de idade do ficheiro

$limit = (Get-Date).AddDays(-60)

# Path em que o scan será realizado
# Ex: $pasta = "C:/"

$pasta = "C:/probasscriptsharepoint/"

# Dados sharepoint
# $urlsharepoint: é necessário indicar o endereço do sharepoint com o seu nºTenant (entre aspas).
#
# To find your Microsoft 365 tenant ID in the Azure AD admin center
# Your tenant ID can be found in the Tenant ID box on the Properties page.
# Ex: $urlsharepoint = "https://<tenant>.sharepoint.com/sites/<sitename>;"

$urlsharepoint = "https://<tenant>.sharepoint.com/sites/<sitename>;"

# $urlworkdir: Pasta Sharepoint na qual as cópias serão guardadas.
# Ex: $urlworkdir = "/sites/<sitename>/Shared Documents/Old Files"

$urlworkdir = "/sites/<sitename>/Shared Documents/Old Files"

# $username e $password: utilizador e palavra-passe autorizados a escrever para sharepoint.
# Ex: $username = "user@domain.com"
#     $password = ConvertTo-SecureString "yourpaswordhere" -AsPlainText -Force

$username = "user@domain.com"
$password = ConvertTo-SecureString "yourpaswordhere" -AsPlainText -Force

####################################################################################
####################################################################################
# Não modificar nada a partir desta linha.
####################################################################################
####################################################################################
# Importação do módulo sharepoint
Import-Module SharePointPnPPowerShellOnline

# Geração de credenciais.
$creds = New-Object System.Management.Automation.PSCredential ($username, $password)

# ligação sharepoint
Connect-PnPOnline -Url $urlsharepoint -Credentials $creds

# detecção de ficheiros com mais de 60 dias.
$files = Get-ChildItem -Path $pasta -Recurse | Where-Object { $_.LastWriteTime -lt $limit }

# Percorrer os ficheiros e movê-los para SharePoint
foreach ($file in $files)
{
    Add-PnPFile -Path $file.FullName -Folder $urlworkdir
    Write-Host "Moved file $($file.FullName) to $urlworkdir"
}
####################################################################################