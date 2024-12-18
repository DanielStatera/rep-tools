$txtDir = "c:\deployTools"
$installerUrl = "https://github.com/glpi-project/glpi-agent/releases/download/1.10/GLPI-Agent-1.10-x64.msi"

$installerPath = "$txtDir\glpi-agent.msi"

Invoke-WebRequest -Uri $installerUrl -OutFile $installerPath

$glpiServer = "https://portal.staterati.com.br/"
# Caso esse script for usado em GPO tira o "#" que esta na frente da linha abaixo e coloque na abaixo dela.
# Após na linha abaixo inserir a TAG da empresa que deseja rodar a GPO

#$tagCliente = "  "
$tagCliente = Read-Host "Digite a TAG: "

Start-Process msiexec.exe -ArgumentList "/i `"$installerPath`" ADDLOCAL=ALL /qn /norestart SERVER=$glpiServer TAG=$tagCliente --quit" -Wait

Remove-Item $installerPath