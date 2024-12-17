# Linha 9 cria uma variavel para criação de uma pasta (C:/JLLACRONIS) Pode utilizar o nome que você quiser.
# Linha 10 cria você deve inserir um token valido para o cliente (gerado no portal do Acronis)
# Linha 24 testa se já existe um acronis instalado e caso negativo Iniciar a instalação 
# Linha 32 baixa o arquivo agente instalador do windows diretamente do site da Acronis e manda salvar no diretorio que vc criou na linha 8
# Linha 44 Executa o arquivo que está baixado no seu diretorio (criado com a variavel da linha 8 e executa como adm) 
# Linha 50 Exclui a pasta criada na linha 9


   # Cria a variavel (PASTA JLL ACRONIS)
$workdir = "c:\deployacronis"
$CloudUrl = "https://br01-cloud.acronis.com/"
$RegistrationToken = "xxxx-xxxx-xxxx"

$sixtyFourBit = Test-Path -Path "C:\Program Files"

$AcronisInstalled = Test-Path -Path "C:\Program Files (x86)\Common Files\Acronis"

If ($AcronisInstalled){ 
    Write-Host "Acronis já está instalado"
    
} ELSE { 
    Write-Host "Begining the installation"

  # Testa se o diretorio existe ou não. 

    If (Test-Path -Path $workdir -PathType Container){ 
        Write-Host "$workdir already exists" -ForegroundColor Red
    } ELSE { 
        New-Item -Path $workdir  -ItemType directory 
    }

    # Baixa o arquivo direto do repositorio da Acronis

    $source = "https://deployacronis.blob.core.windows.net/deployacronis/AcronisCyberProtect_AgentForWindows_Web.exe"
    $destination = "$workdir\AcronisCyberProtect_AgentForWindows_Web.exe"

      if (Get-Command 'Invoke-Webrequest'){
        Invoke-WebRequest $source -OutFile $destination
    } else {
        $WebClient = New-Object System.Net.WebClient
        $webclient.DownloadFile($source, $destination)
    }

  # Inicia a instalação e utiliza o argumento de instalação sem interação do usuário.
    
    Start-Process -FilePath "$workdir\AcronisCyberProtect_AgentForWindows_Web.exe" -ArgumentList "--add-components=commandLine,agentForWindows --reg-address=$CloudUrl --registration=by-token --reg-token=$RegistrationToken --quiet"

    Start-Sleep -s 35

  }