$installerUrl = "https://github.com/glpi-project/glpi-agent/releases/download/1.10/GLPI-Agent-1.10-x64.msi"

$installerPath = "$env:TEMP\glpi-agent.msi"

Invoke-WebRequest -Uri $installerUrl -OutFile $installerPath

$glpiServer = "https://portal.staterati.com.br/"
$tagCliente = $env:tag

Start-Process msiexec.exe -ArgumentList "/i `"$installerPath`" ADDLOCAL=ALL /qn /norestart SERVER=$glpiServer TAG=$tagCliente" -Wait

Remove-Item $installerPath