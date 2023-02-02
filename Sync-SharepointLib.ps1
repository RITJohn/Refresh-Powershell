[CmdletBinding()]
param (
    [Parameter(Mandatory=$true)]
    [string]
    $name,
    [Parameter(Mandatory=$true)]
    [string]
    $lid
)

$ref = ((Get-WMIObject -ClassName Win32_ComputerSystem).Username).Split('\')[1]
$sid = (Get-CimInstance -ClassName Win32_UserAccount -Filter "Name like '$ref'").SID

if (!(Test-Path -Path "Registry::HKEY_USERS\$sid\Software\Policies\Microsoft\OneDrive")) {
    New-Item -Path "Registry::HKEY_USERS\$sid\Software\Policies\Microsoft\OneDrive"
}
if (!(Test-Path -Path "Registry::HKEY_USERS\$sid\Software\Policies\Microsoft\OneDrive\TenantAutoMount")) {
    New-Item -Path "Registry::HKEY_USERS\$sid\Software\Policies\Microsoft\OneDrive\TenantAutoMount"
}
New-ItemProperty -Path "Registry::HKEY_USERS\$sid\Software\Policies\Microsoft\OneDrive\TenantAutoMount" -Name $name -Value $lid -PropertyType String -Force
