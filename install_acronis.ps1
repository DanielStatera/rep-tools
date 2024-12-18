    Write-Host "<===== Instalacao Acronis =====>"

    $workdir = "c:\deployTools"
    $CloudUrl = "https://br01-cloud.acronis.com/"
    $RegistrationToken = " Digite aqui o token do acronis após apagar esta linha "
        
    Write-Host "Verificando Instalacao...."

    $sixtyFourBit = Test-Path -Path "C:\Program Files\Common Files\Acronis"
    $AcronisInstalled = Test-Path -Path "C:\Program Files (x86)\Common Files\Acronis"

    
    If ($AcronisInstalled -or $sixtyFourBit){ 
        Write-Host "Acronis ja esta instalado....."
            
    } ELSE { 
        Write-Host "Testando Diretorios...."
        
        # Testa se o diretorio existe ou não. 
        
        If (Test-Path -Path $workdir -PathType Container){ 
            Write-Host "$workdir already exists" -ForegroundColor Red
        } ELSE { 
            New-Item -Path $workdir  -ItemType directory 
        }
        
        # Baixa o arquivo direto do repositorio da Acronis
            
        Write-Host "Baixando Componentes para Instalacao...."

        $source = "https://github.com/DanielStatera/rep-tools/releases/download/tools/Acronis.exe"
        $destination = "$workdir\Acronis.exe"

        try {
            if (Get-Command 'Invoke-WebRequest') {
                Invoke-WebRequest $source -OutFile $destination
            } else {
                $WebClient = New-Object System.Net.WebClient
                $webclient.DownloadFile($source, $destination)
            }
            
            # Verifica se o arquivo foi baixado corretamente
            if (Test-Path -Path $destination) {
                Write-Host "O arquivo foi baixado com sucesso e esta localizado em $destination." -ForegroundColor Green
                    
                # Opcional: Verificação adicional do tamanho do arquivo
                $fileInfo = Get-Item -Path $destination
                if ($fileInfo.Length -gt 0) {
                    Write-Host "O arquivo foi baixado corretamente e não esta vazio." -ForegroundColor Green
                } else {
                    Write-Host "O arquivo foi baixado, mas parece estar vazio." -ForegroundColor Red
                }
            } else {
                Write-Host "Falha ao baixar o arquivo." -ForegroundColor Red
            }
        } catch {
            Write-Host "Ocorreu um erro durante o download do arquivo: $_" -ForegroundColor Red
        }

        Write-Host "Iniciando a instalação....."
        # Inicia a instalação e utiliza o argumento de instalação sem interação do usuário.
        $process = Start-Process -FilePath "$workdir\Acronis.exe" -ArgumentList "--add-components=commandLine,agentForWindows --reg-address=$CloudUrl --registration=by-token --reg-token=$RegistrationToken --quiet" -Wait -PassThru


        Write-Host "Verificando instalação....."
        # Verifica se o processo foi concluído com sucesso
        if ($process.ExitCode -eq 0) {
            $acronisPath = "C:\Program Files (x86)\Common Files\Acronis"

            if (Test-Path -Path $acronisPath) {
                Write-Host "Acronis foi instalado com sucesso."
            } else {
                Write-Host "Falha na instalacao do Acronis." -ForegroundColor Red
            }
        } else {
            Write-Host "Erro durante a instalacao do Acronis. Codigo de saida: $($process.ExitCode)" -ForegroundColor Red
        }
        
        
    }