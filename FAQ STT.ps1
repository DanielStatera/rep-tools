# Defina o link do arquivo a ser baixado
$url = "https://github.com/DanielStatera/Faq-desktop/releases/download/Production/FaqInstall.exe"

# Defina o caminho e nome do arquivo a ser salvo
$filePath = "C:\FaqInstall.exe"

# Baixe o arquivo com retry
$retryCount = 3
$retryDelay = 5
for ($i = 0; $i -lt $retryCount; $i++) {
    try {
        Invoke-WebRequest -Uri $url -OutFile $filePath -TimeoutSec 300
        break
    } catch {
        Write-Host "Erro ao baixar arquivo. Tentativa $i de $retryCount"
        Start-Sleep -Seconds $retryDelay
    }
}

# Verifique se o arquivo foi baixado corretamente
if (Test-Path -Path $filePath) {
    # Execute o arquivo em modo silencioso
    Start-Process -FilePath $filePath -WindowStyle Hidden -PassThru -Wait

    # Exclua o arquivo após a instalação
    Remove-Item -Path $filePath -Force
} else {
    Write-Host "Erro ao baixar arquivo. Verifique a conexão com o servidor."
}