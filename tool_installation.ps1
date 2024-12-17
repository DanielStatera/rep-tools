
# Varialvel com os dados do display inicial
$txtInitial = @"
<===== Instalacao de Ferramentas Padrao Statera =====>

Esse sistema realiza a instalacao individual ou conjunta das ferramentas padrao da StateraTI

Selecione uma das opcoes abaixo:

1. Acronis
2. GLPI
3. FAQ
4. Todas
5. Encerrar

"@

$txtDir = "c:\deployTools"


function acronis{

    param(
        [string]$workdir,
        [string]$RegistrationToken
    )

    Write-Host "<===== Instalacao Acronis =====>"

    $CloudUrl = "https://br01-cloud.acronis.com/"
    #$RegistrationToken = Read-Host "Digite o Token do CLiente: "
        
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

        # Inicia a instalação e utiliza o argumento de instalação sem interação do usuário.
        $process = Start-Process -FilePath "$workdir\Acronis.exe" -ArgumentList "--add-components=commandLine,agentForWindows --reg-address=$CloudUrl --registration=by-token --reg-token=$RegistrationToken --quiet" -Wait -PassThru

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

}


function glpi{

    param(
        [string]$workdir,
        [string]$tagCliente
    )

    Write-Host "<===== Instalação GLPI =====>"

    $installerUrl = "https://github.com/DanielStatera/rep-tools/releases/download/tools/GLPI-Agent-1.11-x64.msi"

    $installerPath = "$workdir\glpi-agent.msi"

    Write-Host "Baixando Componentes...."

    Invoke-WebRequest -Uri $installerUrl -OutFile $installerPath

    if (Test-Path $installerPath) {

        Write-Output "O arquivo foi baixado com sucesso." -ForegroundColor Green

        $glpiServer = "https://portal.staterati.com.br/"

        $process = Start-Process msiexec.exe -ArgumentList "/i `"$installerPath`" ADDLOCAL=ALL /qn /norestart SERVER=$glpiServer TAG=$tagCliente" -Wait -PassThru -Verb RunAs

        # Verifica se o processo foi concluído com sucesso
        if ($process.ExitCode -eq 0) {
            $acronisPath = "C:\Program Files\GLPI-Agent"

            if (Test-Path -Path $acronisPath) {
                Write-Host "Acronis foi instalado com sucesso." -ForegroundColor Green
            } else {
                Write-Host "Falha na instalacao do GLPI." -ForegroundColor Red
            }
        } else {
            Write-Host "Erro durante a instalacao do GLPI. Codigo de saida: $($process.ExitCode)" -ForegroundColor Red
        }

    }
}


function faq{

    param(
        [string]$workdir
    )

    Write-Host "<==== Instalação FAQ =====>"

    # Defina o link do arquivo a ser baixado
    $url = "https://github.com/DanielStatera/rep-tools/releases/download/tools/FaqInstall.exe"

    # Defina o caminho e nome do arquivo a ser salvo
    $filePath = "$workdir\FaqInstall.exe"

    Write-Host "Baixando Componentes...."

    # Baixe o arquivo com retry
    $retryCount = 3
    $retryDelay = 5
    for ($i = 0; $i -lt $retryCount; $i++) {
        try {
            if (Get-Command 'Invoke-WebRequest') {
                Invoke-WebRequest -Uri $url -OutFile $filePath -TimeoutSec 300
            } else {
                $WebClient = New-Object System.Net.WebClient
                $webclient.DownloadFile($source, $destination)
            }
            break
        } catch {
            Write-Host "Erro ao baixar arquivo. Tentativa $i de $retryCount" -ForegroundColor Red
            Start-Sleep -Seconds $retryDelay
        }
    }

    # Verifique se o arquivo foi baixado corretamente
    if (Test-Path -Path $filePath) {
        # Execute o arquivo em modo silencioso
        Write-Host "Realizando a Instalacao...."
        $process = Start-Process -FilePath $filePath -WindowStyle Hidden -PassThru -Wait -ArgumentList "--quiet" -Verb RunAs

        # Verifica se o processo foi concluído com sucesso
        if ($process.ExitCode -eq 0) {
            $acronisPath = "C:\Program Files (x86)\Common Files\Acronis"

            if (Test-Path -Path $acronisPath) {
                Write-Host "Acronis foi instalado com sucesso." -ForegroundColor Green
            } else {
                Write-Host "Falha na instalacao do FAQ." -ForegroundColor Red
            }
        } else {
            Write-Host "Erro durante a instalacao do FAQ. Codigo de saida: $($process.ExitCode)" -ForegroundColor Red
        }

    } else {
        Write-Host "Erro ao baixar arquivo. Verifique a conexao com o servidor." -ForegroundColor Red
    }

}


function cleaning{

    Write-Host "Removendo Arquivos...."

    Remove-Item -Path $workdir -Recurse -Force

    Write-Host "A pasta e todos os arquivos foram apagados com sucesso."

}


# Loop principal do menu
while ($true) {
    # Exibe o menu
    Write-Host $txtInitial
    
    # Captura a escolha do usuário
    $option = Read-Host "Digite sua opcao: "


    # Verifica qual opção o usuário escolheu
    switch ($option) {
        "1" {
            # Variaveis de dados a serem inseridos
            $tkAcronis = Read-Host "Digite o Token do Acronis: "

            # Funções a serem executadas
            acronis -workdir $txtDir -RegistrationToken $tkAcronis
            cleaning         
        }
        "2" {
            # Variaveis de dados a serem inseridos
            $tagGlpi = Read-Host "Digite a TAG GLPI: "

            # Funções a serem executadas
            glpi -workdir $txtDir -tagCliente $tagGlpi
            cleaning
        }
        "3" {
            # Funções a serem executadas
            faq $txtDir
            cleaning
        }
        "4" {
            # Variaveis de dados a serem inseridos
            $tkAcronis = Read-Host "Digite o Token do Acronis: "
            $tagGlpi = Read-Host "Digite a TAG GLPI: "

            # Funções a serem executadas
            acronis -workdir $txtDir -RegistrationToken $tkAcronis
            glpi -workdir $txtDir -tagCliente $tagGlpi
            faq $txtDir
            cleaning
        }
        "5" {
            return
        }
        default {
            Write-Host "Opcao invalida. Tente novamente." -ForegroundColor Red
        }
    }

}

Write-Host "Script Finalizado" -ForegroundColor Green









