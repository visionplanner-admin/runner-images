param(
    [Parameter (Mandatory=$true)] [string] $TempResourceGroupName,
    [Parameter (Mandatory=$true)] [string] $ClientId,
    [Parameter (Mandatory=$true)] [string] $ClientSecret,
    [Parameter (Mandatory=$true)] [string] $tenantId,
    [Parameter (Mandatory=$true)] [string] $subscriptionId
)

az login --service-principal -u $ClientId -p $ClientSecret --tenant $tenantId
az account set --subscription $subscriptionId

$groupExist = az group exists --name $TempResourceGroupName
if ($groupExist -eq "true") {
    Write-Host "Found a match, deleting temporary files"
    az group delete --name $TempResourceGroupName --yes | Out-Null
    Write-Host "Temporary group was deleted successfully"
} else {
    Write-Host "No temporary groups found"
}
