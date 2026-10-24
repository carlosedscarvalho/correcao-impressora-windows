@echo off
setlocal
title Correcao de impressao - Windows 10 e 11

:: Solicita elevacao para administrador
net session >nul 2>&1
if %errorlevel% neq 0 (
    echo Solicitando permissao de administrador...
    powershell -NoProfile -ExecutionPolicy Bypass -Command "Start-Process -FilePath '%~f0' -Verb RunAs"
    exit /b
)

echo.
echo ============================================
echo   Correcao de impressao - Windows 10 e 11
echo ============================================
echo.
echo ATENCAO:
echo As alteracoes abaixo reduzem protecoes de seguranca
echo relacionadas a impressao e instalacao de drivers.
echo Use somente se sua equipe de TI autorizar.
echo.
choice /C SN /N /M "Deseja continuar? [S]im / [N]ao: "
if errorlevel 2 goto cancelado

echo.
echo [1/4] Ajustando RpcAuthnLevelPrivacyEnabled...
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Print" /v RpcAuthnLevelPrivacyEnabled /t REG_DWORD /d 0 /f
if errorlevel 1 echo ERRO ao alterar RpcAuthnLevelPrivacyEnabled.

echo.
echo [2/4] Ajustando RestrictDriverInstallationToAdministrators...
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows NT\Printers\PointAndPrint" /v RestrictDriverInstallationToAdministrators /t REG_DWORD /d 0 /f
if errorlevel 1 echo ERRO ao alterar RestrictDriverInstallationToAdministrators.

echo.
echo [3/4] Parando o servico de impressao...
net stop spooler

echo.
echo [4/4] Iniciando o servico de impressao...
net start spooler

echo.
echo Processo concluido. Teste a impressao.
echo Recomendacao: restaure as configuracoes de seguranca apos o teste.
goto fim

:cancelado
echo.
echo Operacao cancelada. Nenhuma alteracao foi aplicada.

:fim
echo.
pause
endlocal
