echo ==========================================
echo    CORRECAO DE ERRO DE IMPRESSAO
echo ==========================================
echo.

reg add "HKLM\SYSTEM\CurrentControlSet\Control\Print" /v RpcAuthnLevelPrivacyEnabled /t REG_DWORD /d 0 /f
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows NT\Printers\PointAndPrint" /v RestrictDriverInstallationToAdministrators /t REG_DWORD /d 0 /f
net stop spooler
net start spooler




echo. ==========================================
echo.         PROCESSO FINALIZADO!
echo.           by: dudusousa.c
echo. ==========================================


pause
