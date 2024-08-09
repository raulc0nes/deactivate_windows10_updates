@echo off
:: Verificar si el script está siendo ejecutado como administrador
openfiles >nul 2>&1 || (
    echo Set UAC = CreateObject^("Shell.Application"^) > "%temp%\getadmin.vbs"
    echo UAC.ShellExecute "%~s0", "", "", "runas", 1 >> "%temp%\getadmin.vbs"
    del "%temp%\getadmin.vbs"
    exit /B
)

:: Sugerencia para reiniciar en Modo Seguro
echo "Se recomienda ejecutar este script en Modo Seguro para mayor efectividad."
echo "Presione Ctrl+C para cancelar, o cualquier otra tecla para continuar."
pause

:: Crear un archivo temporal de PowerShell
set temp_powershell_script=%temp%\temp_windows_update_disable.ps1
set log_file=%temp%\windows_update_disable_log.txt

:: Escribir el script de PowerShell en el archivo temporal
echo try { > %temp_powershell_script%

:: Tomar posesión de las claves de registro y cambiar permisos usando icacls
echo Write-Output "Tomando posesión de claves de registro y cambiando permisos..." >> %temp_powershell_script%
echo icacls "HKLM\SYSTEM\CurrentControlSet\Services\wuauserv" /grant Administradores:F /t /c >> %temp_powershell_script%
echo icacls "HKLM\SYSTEM\CurrentControlSet\Services\UsoSvc" /grant Administradores:F /t /c >> %temp_powershell_script%
echo icacls "HKLM\SYSTEM\CurrentControlSet\Services\WaaSMedicSvc" /grant Administradores:F /t /c >> %temp_powershell_script%
echo icacls "HKLM\SYSTEM\CurrentControlSet\Services\BITS" /grant Administradores:F /t /c >> %temp_powershell_script%
echo icacls "HKLM\SYSTEM\CurrentControlSet\Services\Dosvc" /grant Administradores:F /t /c >> %temp_powershell_script%
echo icacls "HKLM\SYSTEM\CurrentControlSet\Services\wscsvc" /grant Administradores:F /t /c >> %temp_powershell_script%

:: Desactivar servicios críticos en el registro
echo Write-Output "Desactivando servicios críticos en el registro..." >> %temp_powershell_script%
echo reg add "HKLM\SYSTEM\CurrentControlSet\Services\wuauserv" /v "Start" /t REG_DWORD /d 4 /f >> %temp_powershell_script%
echo reg add "HKLM\SYSTEM\CurrentControlSet\Services\UsoSvc" /v "Start" /t REG_DWORD /d 4 /f >> %temp_powershell_script%
echo reg add "HKLM\SYSTEM\CurrentControlSet\Services\WaaSMedicSvc" /v "Start" /t REG_DWORD /d 4 /f >> %temp_powershell_script%
echo reg add "HKLM\SYSTEM\CurrentControlSet\Services\BITS" /v "Start" /t REG_DWORD /d 4 /f >> %temp_powershell_script%
echo reg add "HKLM\SYSTEM\CurrentControlSet\Services\Dosvc" /v "Start" /t REG_DWORD /d 4 /f >> %temp_powershell_script%
echo reg add "HKLM\SYSTEM\CurrentControlSet\Services\wscsvc" /v "Start" /t REG_DWORD /d 4 /f >> %temp_powershell_script%

:: Deshabilitar servicios directamente
echo    function Disable-Service { >> %temp_powershell_script%
echo        param ( >> %temp_powershell_script%
echo            [string]$serviceName >> %temp_powershell_script%
echo        ) >> %temp_powershell_script%
echo        Write-Output "Desactivando el servicio: $serviceName..." >> %temp_powershell_script%
echo        sc.exe stop $serviceName >> %temp_powershell_script%
echo        Start-Sleep -Seconds 5 >> %temp_powershell_script%
echo        sc.exe config $serviceName start= disabled >> %temp_powershell_script%
echo        Write-Output "Servicio $serviceName deshabilitado." >> %temp_powershell_script%
echo    } >> %temp_powershell_script%

echo    Disable-Service -serviceName 'wuauserv' >> %temp_powershell_script%
echo    Disable-Service -serviceName 'UsoSvc' >> %temp_powershell_script%
echo    Disable-Service -serviceName 'Dosvc' >> %temp_powershell_script%
echo    Disable-Service -serviceName 'BITS' >> %temp_powershell_script%
echo    Disable-Service -serviceName 'wscsvc' >> %temp_powershell_script%

:: Deshabilitar tareas programadas que puedan interferir
echo Write-Output "Deshabilitando tareas de Windows Update en el Programador de Tareas..." >> %temp_powershell_script%
echo    $tasks = @("\Microsoft\Windows\WindowsUpdate\Scheduled Start", "\Microsoft\Windows\UpdateOrchestrator\Report policies", "\Microsoft\Windows\UpdateOrchestrator\Schedule Maintenance Work", "\Microsoft\Windows\UpdateOrchestrator\Schedule Scan", "\Microsoft\Windows\UpdateOrchestrator\Schedule Scan Static Task", "\Microsoft\Windows\UpdateOrchestrator\Schedule Wake To Work", "\Microsoft\Windows\UpdateOrchestrator\Schedule Work", "\Microsoft\Windows\UpdateOrchestrator\UpdateModelTask", "\Microsoft\Windows\UpdateOrchestrator\USO_UxBroker", "\Microsoft\Windows\Application Experience\Microsoft Compatibility Appraiser", "\Microsoft\Windows\Application Experience\PcaPatchDbTask", "\Microsoft\Windows\Application Experience\ProgramDataUpdater", "\Microsoft\Windows\Application Experience\StartupAppTask") >> %temp_powershell_script%

echo    foreach ($task in $tasks) { >> %temp_powershell_script%
echo        schtasks.exe /Change /TN $task /Disable >> %temp_powershell_script%
echo        if ($LastExitCode -ne 0) { >> %temp_powershell_script%
echo            schtasks.exe /Delete /TN $task /F >> %temp_powershell_script%
echo            Write-Output "Tarea eliminada: $task" >> %temp_powershell_script%
echo        } else { >> %temp_powershell_script%
echo            Write-Output "Tarea deshabilitada: $task" >> %temp_powershell_script%
echo        } >> %temp_powershell_script%
echo    } >> %temp_powershell_script%

echo    Write-Output 'Actualizaciones automáticas de Windows desactivadas con éxito.' >> %temp_powershell_script%
echo } catch { Write-Output "Ocurrió un error: $_" } >> %temp_powershell_script%

:: Ejecutar el script de PowerShell y redirigir el output a un archivo de log
powershell -NoProfile -ExecutionPolicy Bypass -File %temp_powershell_script% > %log_file% 2>&1

:: Mostrar el contenido del log en pantalla
type %log_file%

:: Mantener la ventana abierta hasta que el usuario presione una tecla
pause

:: Eliminar el archivo temporal y el log
del %temp_powershell_script%
del %log_file%
