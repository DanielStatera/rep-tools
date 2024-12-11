# Uninstall Cyber Protect Agent

function Send-Statistics
{
    param (
        [string]$cloudUrl,
        [string]$accessToken,
        [string]$eventAction = "",
        [int]$eventValue = 0
    )

    $scriptName = "UninstallAgent"
    $scriptVersion = "1.0.0.0"
    $scriptLabel = "Windows"
    $vendorName = "NinjaRMM"
    $vendorVersion = "1.0.0.0"

    if ($eventAction -eq "") {
        $eventAction=$scriptName
    }

    $acronisRegistryPath = "HKLM:\SOFTWARE\Acronis\BackupAndRecovery\Settings\MachineManager"
    $resourceId = Get-ItemProperty -Path $acronisRegistryPath -ErrorAction SilentlyContinue | Select-Object -ExpandProperty InstanceID
    $agentId = Get-ItemProperty -Path $acronisRegistryPath -ErrorAction SilentlyContinue | Select-Object -ExpandProperty MMSCurrentMachineID

    $headers = @{
        "Content-Type"  = "application/json"
        "Authorization" = "Bearer $accessToken"
    }

    $body = @{
        "application_id" = "663f3e60-975a-46d2-bd23-76bc40cd2ecc"
        "workload" = @{
            "agent_id" = $agentId.ToLower()
            "resource_id" = $resourceId.ToLower()
            "hostname" = [Environment]::MachineName
        }
        "module" = @{
            "name" = $scriptName
            "version" = $scriptVersion
        }
        "vendor_system" = @{
            "name" = $vendorName
            "version" = $vendorVersion
        }

        "events" = @(
                @{
                    "label" = $scriptLabel
                    "category" = $scriptName
                    "value" = $eventValue
                    "action" = $eventAction
                }
            )
    } | ConvertTo-Json

    try
    {
        Invoke-WebRequest -Uri "${cloudUrl}/api/integration_management/v2/status" -UseBasicParsing `
            -Method Post `
            -Headers $headers `
            -Body $body | Out-Null
    }catch{
        # this part of the script could fail silently
        return
    }
}

function UseTLS12 {
    try {
        [Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
    }
    catch {
        Write-Error "The host doesn't support TLS v1.2. It's required to proceed. The recomennded minumum version of PowerShell is 4.0."
        exit
    }
}

function Get-AakoreProxyURL {
    $aakoreCmdOutput = &"${env:CommonProgramFiles}\Acronis\Agent\aakore.exe" "info" "--raw" | Out-String
    $aakoreCmdOutput = $aakoreCmdOutput.Replace([System.Environment]::NewLine, '').Replace("}{", "},{")
    $aakoreCmdOutput = "[${aakoreCmdOutput}]"
    $aakoreInfo = $aakoreCmdOutput | ConvertFrom-Json
    return $aakoreInfo[0].location
}

function Get-AccessToken {
    param ([string] $proxyURL)
    # Get client ID and client secret from aakore
    $aakoreClient = Invoke-RestMethod -Uri "${proxyURL}/idp/clients" `
        -Method Post `
        -UseDefaultCredentials `
        -SessionVariable aakoreSession
    $clientId = $aakoreClient.client_id
    $clientSecret = $aakoreClient.client_secret

    $clientIdSecretBytes = [System.Text.Encoding]::ASCII.GetBytes("${clientId}:${clientSecret}")
    $clientIdSecretBase64 = [System.Convert]::ToBase64String($clientIdSecretBytes)
    $headers = @{
        "Authorization" = "Basic $clientIdSecretBase64"
        "Content-Type"  = "application/x-www-form-urlencoded"
    }
    $body = @{ grant_type = "client_credentials" }
    $response = Invoke-RestMethod -Uri "${proxyURL}/idp/token" `
        -Method Post `
        -Headers $headers `
        -Body $body `
        -WebSession $aakoreSession

    return $response.access_token
}

function Get-UpgradeCode {
    if ([System.Environment]::Is64BitOperatingSystem) {
        '{DAC56B69-1A5E-494D-92AE-A462FFB2A281}'
    }
    else {
        '{48557248-4EE3-49E4-9450-BAADC7CD1A88}'
    }
}

function Get-ProductCode {
    param ([string] $upgradeCode)

    return Get-CimInstance -ClassName Win32_Property -Filter "Property='UpgradeCode' AND Value='$upgradeCode'" |
    Select-Object -First 1 -ExpandProperty ProductCode
}

function Get-Product {
    param ([string] $productCode)

    return Get-WmiObject -Class Win32_Product | Where-Object { $_.IdentifyingNumber -match $productCode }
}

# Check if the Cyper Protect is installed
if (!(Test-Path "${env:CommonProgramFiles}\Acronis\Agent\aakore.exe")) {
    Write-Error "Cannot find Acronis Cyber Protection installation on this machine. Check the installation."
    exit
}

# The minimum required security protocol is TLS1.2 try to set it
UseTLS12

# read the proxy url from AAKORE
$proxyURL = Get-AakoreProxyURL

# create new access token
$accessToken = Get-AccessToken $proxyURL
Send-Statistics -cloudUrl $proxyURL -accessToken $accessToken

$upgradeCode = Get-UpgradeCode
$productCode = Get-ProductCode $upgradeCode
$product = Get-Product $productCode

if ($product) {
    $product.Uninstall()

    if (Get-Product $productCode) {
        Write-Error "Failed to uninstall Cyber Protect Agent"
    }
    else {
        Write-Output "Cyber Protect Agent was uninstalled successfully"
    }
}