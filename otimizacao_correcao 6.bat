@echo off
echo Iniciando script de otimização e correção de sistema...

:: Desliga programas em segundo plano que podem interferir
taskkill /f /im chrome.exe
taskkill /f /im firefox.exe
taskkill /f /im iexplore.exe
:: Adicione mais linhas 'taskkill' conforme necessário para outros programas

:: Limpa arquivos temporários
echo Limpando arquivos temporários...
del /q /s %TEMP%\*.*
del /q /s %SystemRoot%\Temp\*.*

:: Verifica e corrige a integridade do sistema
echo Verificando e corrigindo a integridade do sistema...
sfc /scannow

:: Verifica a saúde da imagem do sistema
echo Verificando a saúde da imagem do sistema...
dism /online /cleanup-image /scanhealth

:: Restaura a saúde da imagem do sistema
echo Restaurando a saúde da imagem do sistema...
dism /online /cleanup-image /restorehealth

:: Otimização de disco
echo Otimizando disco...
defrag C: /U /V
:: Substitua C: pelo disco que deseja desfragmentar, se necessário

:: Executa a verificação e correção de erros no disco
echo Verificando e corrigindo erros no disco...
chkdsk C: /F /R
:: Substitua C: pelo disco que deseja verificar, se necessário


