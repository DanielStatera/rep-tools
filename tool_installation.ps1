
# Varialvel com os dados do display inicial
$txtInitial = @"
<===== Instalacao de Ferramentas Padrao Statera =====>

Esse sistema realiza a instalacao individual ou conjunta das ferramentas padrao da StateraTI

Selecione uma das opcoes abaixo:

1. Acronis
2. GLPI
3. FAQ
4. Tactical
5. Todas
6. Encerrar

"@


# Dicionário com as informações Tactical Clientes
$companies = @{
    "15" = @{ company_name = "Acesso Contabilidade"; ID_site = "18"; Site = "Matriz" }
    "16" = @{ company_name = "ADEPMG"; ID_site = "19"; Site = "Matriz" }
    "17" = @{ company_name = "Arca Assessoria Contábil"; ID_site = "20"; Site = "Matriz" }
    "18" = @{ company_name = "Asjuric"; ID_site = "21"; Site = "Matriz" }
    "7"  = @{ company_name = "ATR Emp. Contábeis"; ID_site = "10"; Site = "Matriz" }
    "10" = @{ company_name = "Big Foods - Mc Donalds"; ID_site = 13; Site = "Matriz" }
    "14" = @{ company_name = "Brugnara"; ID_site = "17"; Site = "Matriz" }
    "21" = @{ company_name = "Carvalho e Pinheiro - C&P"; ID_site = "24"; Site = "Matriz" }
    "65" = @{ company_name = "CGDC - Consultar Contabilidade"; ID_site = "87"; Site = "Matriz" }
    "23" = @{ company_name = "Conceito Logistica"; ID_site = "26"; Site = "Matriz" }
    "4"  = @{ company_name = "Conexus"; ID_site = "8"; Site = "Inetsafe" }
    "8"  = @{ company_name = "Consistem"; ID_site = "11"; Site = "Matriz" }
    "11" = @{ company_name = "Consultar Consultoria"; ID_site = "14"; Site = "Matriz" }
    "2"  = @{ company_name = "Contac Cont."; ID_site = "2"; Site = "Matriz" }
    "27" = @{ company_name = "Contfacil"; ID_site = "30"; Site = "Matriz" }
    "12" = @{ company_name = "Diamante Gestão"; ID_site = "15"; Site = "Matriz" }
    "39" = @{ company_name = "DMS Assessoria"; ID_site = "42"; Site = "Matriz" }
    "28" = @{ company_name = "DSD Controller"; ID_site = "31"; Site = "Matriz" }
    "40" = @{ company_name = "Duarte"; ID_site = "43"; Site = "Matriz" }
    "13" = @{ company_name = "Eletroforte"; ID_site = "16"; Site = "Matriz" }
    "30" = @{ company_name = "Eletro Painel"; ID_site = "33"; Site = "Matriz" }
    "29" = @{ company_name = "ESAP Service"; ID_site = "32"; Site = "Matriz" }
    "60" = @{ company_name = "Ferreira e Silva"; ID_site = "65"; Site = "Matriz" }
    "41" = @{ company_name = "FETCEMG"; ID_site = "44"; Site = "Matriz" }
    "62" = @{ company_name = "Grupo Prisma"; ID_site = "77"; Site = "Comercial Prisma" }
    "31" = @{ company_name = "Icro Group"; ID_site = "68"; Site = "Alfenas" }
    "37" = @{ company_name = "Kaizzen"; ID_site = "40"; Site = "Matriz" }
    "25" = @{ company_name = "Linion Isolantes"; ID_site = "28"; Site = "Matriz" }
    "42" = @{ company_name = "Lino Amorim"; ID_site = "45"; Site = "Matriz" }
    "43" = @{ company_name = "Malafaia e Veiga - M&V"; ID_site = "46"; Site = "Matriz" }
    "44" = @{ company_name = "MCosta"; ID_site = "47"; Site = "Matriz" }
    "64" = @{ company_name = "Measure Soluções em Geomensura"; ID_site = "86"; Site = "Matriz" }
    "6"  = @{ company_name = "Millennium Consultoria"; ID_site = "9"; Site = "Matriz" }
    "3"  = @{ company_name = "Miranda e Costa"; ID_site = "3"; Site = "Matriz" }
    "26" = @{ company_name = "MVE Contabilidade"; ID_site = "29"; Site = "Matriz" }
    "58" = @{ company_name = "Pascon e Freitas Consultoria"; ID_site = "63"; Site = "Matriz" }
    "24" = @{ company_name = "Penatec"; ID_site = "27"; Site = "Matriz" }
    "45" = @{ company_name = "Policont Contabilidade"; ID_site = "48"; Site = "Matriz" }
    "46" = @{ company_name = "PWA Service Projetos Industriais"; ID_site = "49"; Site = "Matriz" }
    "20" = @{ company_name = "Real Cred - Tok Real Promotora"; ID_site = "23"; Site = "Matriz" }
    "32" = @{ company_name = "Regina Salomão"; ID_site = "73"; Site = "Fabrica BH" }
    "33" = @{ company_name = "Rei dos Estojos"; ID_site = "36"; Site = "Matriz" }
    "34" = @{ company_name = "RPO"; ID_site = "37"; Site = "Matriz" }
    "47" = @{ company_name = "RVG"; ID_site = "50"; Site = "Matriz" }
    "48" = @{ company_name = "Salvatore Contabilidade"; ID_site = "51"; Site = "Matriz" }
    "61" = @{ company_name = "Santos Dumont"; ID_site = "75"; Site = "Matriz" }
    "49" = @{ company_name = "SCD - Seu Contador Digital"; ID_site = "52"; Site = "Matriz" }
    "54" = @{ company_name = "Sollar Equipamentos"; ID_site = "57"; Site = "Matriz" }
    "66" = @{ company_name = "STT"; ID_site = "88"; Site = "Matriz" }
    "55" = @{ company_name = "Supply Service"; ID_site = "58"; Site = "Matriz" }
    "36" = @{ company_name = "TMT"; ID_site = "39"; Site = "Matriz" }
    "19" = @{ company_name = "Única Promotora"; ID_site = "66"; Site = "Florianópolis" }
    "38" = @{ company_name = "Vibracon Engenharia"; ID_site = "41"; Site = "Matriz" }
    "56" = @{ company_name = "Wilson Contabilidade"; ID_site = "59"; Site = "Matriz" }
}


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

        $glpiServer = "https://GLPI.exemplo.com.br/"


        Write-Host "Instalando GLPI...."
        $process = Start-Process msiexec.exe -ArgumentList "/i `"$installerPath`" ADDLOCAL=ALL /qn /norestart SERVER=$glpiServer TAG=$tagCliente" -Wait -PassThru -Verb RunAs

        Write-Host "Verificando Instalação....."
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


function tactical_install{

    param(
        [string]$paramClientid,
        [string]$paramSiteid

    )

    # author: https://github.com/bradhawkins85
    $innosetup = 'tacticalagent-v2.8.0-windows-amd64.exe'
    
    #Tem que colocar o url correta
    $api = '"https://api.exemplo.com.br"'

    $clientid = $paramClientid
    $siteid = $paramSiteid
    $agenttype = '"workstation"'
    $power = 0
    $rdp = 1
    $ping = 1

    # Mudar para um auth valido
    $auth = '"TA ACHANDO QUE TO MALUCO DE MOSTRAR MINHA KEY DOIDÃO"'
    $downloadlink = 'https://github.com/amidaware/rmmagent/releases/download/v2.8.0/tacticalagent-v2.8.0-windows-amd64.exe'
    $apilink = $downloadlink.split('/')

    [Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12

    $serviceName = 'tacticalrmm'
    If (Get-Service $serviceName -ErrorAction SilentlyContinue) {
        write-host ('Tactical RMM Is Already Installed')
    } Else {
        $OutPath = $env:TMP
        $output = $innosetup

        $installArgs = @('-m install --api ', "$api", '--client-id', $clientid, '--site-id', $siteid, '--agent-type', "$agenttype", '--auth', "$auth", "--quiet")

        if ($power) {
            $installArgs += "--power"
        }

        if ($rdp) {
            $installArgs += "--rdp"
        }

        if ($ping) {
            $installArgs += "--ping"
        }

        Try
        {
            $DefenderStatus = Get-MpComputerStatus | select  AntivirusEnabled
            if ($DefenderStatus -match "True") {
                Add-MpPreference -ExclusionPath 'C:\Program Files\TacticalAgent\*'
                Add-MpPreference -ExclusionPath 'C:\Program Files\Mesh Agent\*'
                Add-MpPreference -ExclusionPath 'C:\ProgramData\TacticalRMM\*'
            }
        }
        Catch {
            # pass
        }
        
        $X = 0
        do {
         "Waiting for network"
        Start-Sleep -s 5
        $X += 1      
        } until(($connectresult = Test-NetConnection $apilink[2] -Port 443 | ? { $_.TcpTestSucceeded }) -or $X -eq 3)
        
        if ($connectresult.TcpTestSucceeded -eq $true){
            Try
            {  
                Invoke-WebRequest -Uri $downloadlink -OutFile $OutPath\$output
                Start-Process -FilePath $OutPath\$output -ArgumentList ('/VERYSILENT /SUPPRESSMSGBOXES') -Wait
                write-host ('Extracting...')
                Start-Sleep -s 5
                Write-Host "Instalando....."
                Start-Process -FilePath "C:\Program Files\TacticalAgent\tacticalrmm.exe" -ArgumentList $installArgs -Wait
                exit 0
            }
            Catch
            {
                $ErrorMessage = $_.Exception.Message
                $FailedItem = $_.Exception.ItemName
                Write-Error -Message "$ErrorMessage $FailedItem"
                exit 1
            }
            Finally
            {
                Remove-Item -Path $OutPath\$output
            }
        } else {
             "Unable to connect to server"
        }
    }


}


function tactical_settings{

    param(
        [string]$id
    )

    # Switch case para executar comandos com base no ID
    switch ($id) {
        15 { 
            $ID_site = $companies[$id].ID_site
            $company_name = $companies[$id].company_name

            Write-Host "Você ira instalar o Tactical na company_name: $cpm"
            
            tactical_install -paramClientid $id -paramClientid $ID_site

        }
        16 { 
            $ID_site = $companies[$id].ID_site
            $company_name = $companies[$id].company_name

            Write-Host "Você ira instalar o Tactical na company_name: $cpm"

            tactical_install -paramClientid $id -paramClientid $ID_site
        
        }
        17 { 
            $ID_site = $companies[$id].ID_site
            $company_name = $companies[$id].company_name

            Write-Host "Você ira instalar o Tactical na company_name: $cpm"
            
            tactical_install -paramClientid $id -paramClientid $ID_site
        }
        18 { 
            $ID_site = $companies[$id].ID_site
            $company_name = $companies[$id].company_name

            Write-Host "Você ira instalar o Tactical na company_name: $cpm"
        
            tactical_install -paramClientid $id -paramClientid $ID_site
            
        }
        7  { 
            $ID_site = $companies[$id].ID_site
            $company_name = $companies[$id].company_name

            Write-Host "Você ira instalar o Tactical na company_name: $cpm"

            tactical_install -paramClientid $id -paramClientid $ID_site

        }
        10 { 
            $ID_site = $companies[$id].ID_site
            $company_name = $companies[$id].company_name

            Write-Host "Você ira instalar o Tactical na company_name: $cpm"

            tactical_install -paramClientid $id -paramClientid $ID_site
        
        }
        14 { 
            $ID_site = $companies[$id].ID_site
            $company_name = $companies[$id].company_name

            Write-Host "Você ira instalar o Tactical na company_name: $cpm"

            tactical_install -paramClientid $id -paramClientid $ID_site
        
        }
        21{ 
            $ID_site = $companies[$id].ID_site
            $company_name = $companies[$id].company_name

            Write-Host "Você ira instalar o Tactical na company_name: $cpm"

            tactical_install -paramClientid $id -paramClientid $ID_site
        
        }
        65 { 
            $ID_site = $companies[$id].ID_site
            $company_name = $companies[$id].company_name

            Write-Host "Você ira instalar o Tactical na company_name: $cpm"

            tactical_install -paramClientid $id -paramClientid $ID_site
        
        }
        23 { 
            $ID_site = $companies[$id].ID_site
            $company_name = $companies[$id].company_name

            Write-Host "Você ira instalar o Tactical na company_name: $cpm"

            tactical_install -paramClientid $id -paramClientid $ID_site
        
        }
        4{ 
            $ID_site = $companies[$id].ID_site
            $company_name = $companies[$id].company_name

            Write-Host "Você ira instalar o Tactical na company_name: $cpm"

            tactical_install -paramClientid $id -paramClientid $ID_site
        
        }
        8 { 
            $ID_site = $companies[$id].ID_site
            $company_name = $companies[$id].company_name

            Write-Host "Você ira instalar o Tactical na company_name: $cpm"

            tactical_install -paramClientid $id -paramClientid $ID_site
        
        }
        11 { 
            $ID_site = $companies[$id].ID_site
            $company_name = $companies[$id].company_name

            Write-Host "Você ira instalar o Tactical na company_name: $cpm"

            tactical_install -paramClientid $id -paramClientid $ID_site
        
        }
        2  { 
            $ID_site = $companies[$id].ID_site
            $company_name = $companies[$id].company_name

            Write-Host "Você ira instalar o Tactical na company_name: $cpm"

            tactical_install -paramClientid $id -paramClientid $ID_site
        
        }
        27 { 
            $ID_site = $companies[$id].ID_site
            $company_name = $companies[$id].company_name

            Write-Host "Você ira instalar o Tactical na company_name: $cpm"

            tactical_install -paramClientid $id -paramClientid $ID_site
        
        }
        12 { 
            $ID_site = $companies[$id].ID_site
            $company_name = $companies[$id].company_name

            Write-Host "Você ira instalar o Tactical na company_name: $cpm"

            tactical_install -paramClientid $id -paramClientid $ID_site
        
        }
        39 { 
            $ID_site = $companies[$id].ID_site
            $company_name = $companies[$id].company_name

            Write-Host "Você ira instalar o Tactical na company_name: $cpm"

            tactical_install -paramClientid $id -paramClientid $ID_site
        
        }
        28 { 
            $ID_site = $companies[$id].ID_site
            $company_name = $companies[$id].company_name

            Write-Host "Você ira instalar o Tactical na company_name: $cpm"

            tactical_install -paramClientid $id -paramClientid $ID_site
        
        }
        40 { 
            $ID_site = $companies[$id].ID_site
            $company_name = $companies[$id].company_name

            Write-Host "Você ira instalar o Tactical na company_name: $cpm"

            tactical_install -paramClientid $id -paramClientid $ID_site
        
        }
        13 { 
            $ID_site = $companies[$id].ID_site
            $company_name = $companies[$id].company_name

            Write-Host "Você ira instalar o Tactical na company_name: $cpm"

            tactical_install -paramClientid $id -paramClientid $ID_site
        
        }
        30 { 
            $ID_site = $companies[$id].ID_site
            $company_name = $companies[$id].company_name

            Write-Host "Você ira instalar o Tactical na company_name: $cpm"

            tactical_install -paramClientid $id -paramClientid $ID_site
        
        }
        29 { 
            $ID_site = $companies[$id].ID_site
            $company_name = $companies[$id].company_name

            Write-Host "Você ira instalar o Tactical na company_name: $cpm"

            tactical_install -paramClientid $id -paramClientid $ID_site
        
        }
        60 { 
            $ID_site = $companies[$id].ID_site
            $company_name = $companies[$id].company_name

            Write-Host "Você ira instalar o Tactical na company_name: $cpm"

            tactical_install -paramClientid $id -paramClientid $ID_site
        
        }
        41 { 
            $ID_site = $companies[$id].ID_site
            $company_name = $companies[$id].company_name

            Write-Host "Você ira instalar o Tactical na company_name: $cpm"

            tactical_install -paramClientid $id -paramClientid $ID_site
        
        }
        62 { 
            $ID_site = $companies[$id].ID_site
            $company_name = $companies[$id].company_name

            Write-Host "Você ira instalar o Tactical na company_name: $cpm"

            tactical_install -paramClientid $id -paramClientid $ID_site
        
        }
        31 { 
            $ID_site = $companies[$id].ID_site
            $company_name = $companies[$id].company_name

            Write-Host "Você ira instalar o Tactical na company_name: $cpm"

            tactical_install -paramClientid $id -paramClientid $ID_site
        
        }
        37 { 
            $ID_site = $companies[$id].ID_site
            $company_name = $companies[$id].company_name

            Write-Host "Você ira instalar o Tactical na company_name: $cpm"

            tactical_install -paramClientid $id -paramClientid $ID_site
        
        }
        25 { 
            $ID_site = $companies[$id].ID_site
            $company_name = $companies[$id].company_name

            Write-Host "Você ira instalar o Tactical na company_name: $cpm"

            tactical_install -paramClientid $id -paramClientid $ID_site
        
        }
        42 { 
            $ID_site = $companies[$id].ID_site
            $company_name = $companies[$id].company_name

            Write-Host "Você ira instalar o Tactical na company_name: $cpm"

            tactical_install -paramClientid $id -paramClientid $ID_site
        
        }
        43 { 
            $ID_site = $companies[$id].ID_site
            $company_name = $companies[$id].company_name

            Write-Host "Você ira instalar o Tactical na company_name: $cpm"

            tactical_install -paramClientid $id -paramClientid $ID_site
        
        }
        44 { 
            $ID_site = $companies[$id].ID_site
            $company_name = $companies[$id].company_name

            Write-Host "Você ira instalar o Tactical na company_name: $cpm"

            tactical_install -paramClientid $id -paramClientid $ID_site
        
        }
        64 { 
            $ID_site = $companies[$id].ID_site
            $company_name = $companies[$id].company_name

            Write-Host "Você ira instalar o Tactical na company_name: $cpm"

            tactical_install -paramClientid $id -paramClientid $ID_site
        
        }
        6  { 
            $ID_site = $companies[$id].ID_site
            $company_name = $companies[$id].company_name

            Write-Host "Você ira instalar o Tactical na company_name: $cpm"

            tactical_install -paramClientid $id -paramClientid $ID_site
        
        }
        3  { 
            $ID_site = $companies[$id].ID_site
            $company_name = $companies[$id].company_name

            Write-Host "Você ira instalar o Tactical na company_name: $cpm"

            tactical_install -paramClientid $id -paramClientid $ID_site
        
        }
        26 { 
            $ID_site = $companies[$id].ID_site
            $company_name = $companies[$id].company_name

            Write-Host "Você ira instalar o Tactical na company_name: $cpm"

            tactical_install -paramClientid $id -paramClientid $ID_site
        
        }
        58 { 
            $ID_site = $companies[$id].ID_site
            $company_name = $companies[$id].company_name

            Write-Host "Você ira instalar o Tactical na company_name: $cpm"

            tactical_install -paramClientid $id -paramClientid $ID_site
        
        }
        default {  "ID não encontrado" }
    
    }


}


function cleaning{

    Write-Host "Removendo Arquivos...."

    Remove-Item -Path $txtDir -Recurse -Force

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

            $id = Read-Host "Digite o ID do Cliente: "

            # Funções a serem executadas
            tactical_settings $id
        }
        "5" {
            # Variaveis de dados a serem inseridos
            $tkAcronis = Read-Host "Digite o Token do Acronis: "
            $tagGlpi = Read-Host "Digite a TAG GLPI: "
            $id = Read-Host "Digite o ID do Cliente: "

            # Funções a serem executadas
            acronis -workdir $txtDir -RegistrationToken $tkAcronis
            glpi -workdir $txtDir -tagCliente $tagGlpi
            tactical_settings $id
            faq $txtDir
            cleaning
        }
        "6" {
            return
        }
        default {
            Write-Host "Opcao invalida. Tente novamente." -ForegroundColor Red
        }
    }

}

Write-Host "Script Finalizado" -ForegroundColor Green









