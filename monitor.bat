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

:: Crear rutas para el script de PowerShell y el log
set powershell_script_path=C:\Scripts\MonitorWindowsUpdate.ps1
set log_file=C:\Logs\WindowsUpdateMonitor.log

:: Crear la carpeta de logs y scripts si no existe
if not exist "C:\Logs" mkdir "C:\Logs"
if not exist "C:\Scripts" mkdir "C:\Scripts"

:: Pausa para asegurar la creación de carpetas
timeout /t 2 /nobreak >nul

:: Escribir el script de PowerShell en el archivo MonitorWindowsUpdate.ps1
echo try { > %powershell_script_path%
echo    $registryPath = "HKLM:\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate\AU" >> %powershell_script_path%
echo    $registryKey = "NoAutoUpdate" >> %powershell_script_path%
echo    function Write-Log { >> %powershell_script_path%
echo        param ([string]$message) >> %powershell_script_path%
echo        $timestamp = Get-Date -Format "yyyy-MM-dd HH:mm:ss" >> %powershell_script_path%
echo        $logMessage = "$timestamp - $message" >> %powershell_script_path%
echo        Add-Content -Path "%log_file%" -Value $logMessage >> %powershell_script_path%
echo    } >> %powershell_script_path%
echo    function Get-LastModifiedProcess { >> %powershell_script_path%
echo        $events = Get-WinEvent -FilterHashtable @{LogName='Security'; Id=4656} ^| Where-Object { $_.Properties[5].Value -match "WindowsUpdate\\AU" } ^| Select-Object -First 1 >> %powershell_script_path%
echo        if ($events) { >> %powershell_script_path%
echo            $processName = $events.Properties[8].Value >> %powershell_script_path%
echo            $userName = $events.Properties[1].Value >> %powershell_script_path%
echo            $timeCreated = $events.TimeCreated >> %powershell_script_path%
echo            return "Modificacion realizada por: $processName ($userName) a las $timeCreated" >> %powershell_script_path%
echo        } else { >> %powershell_script_path%
echo            return "Proceso de modificacion no detectado" >> %powershell_script_path%
echo        } >> %powershell_script_path%
echo    } >> %powershell_script_path%
echo    while ($true) { >> %powershell_script_path%
echo        try { >> %powershell_script_path%
echo            $currentValue = Get-ItemProperty -Path $registryPath -Name $registryKey -ErrorAction Stop >> %powershell_script_path%
echo            if ($currentValue.NoAutoUpdate -ne 1) { >> %powershell_script_path%
echo                Set-ItemProperty -Path $registryPath -Name $registryKey -Value 1 -ErrorAction Stop >> %powershell_script_path%
echo                $processInfo = Get-LastModifiedProcess >> %powershell_script_path%
echo                Write-Log "Intento de cambio en $registryKey detectado y revertido. $processInfo" >> %powershell_script_path%
echo                powershell -Command "Add-Type -AssemblyName PresentationFramework;[System.Windows.MessageBox]::Show('Intento de cambio en el registro de Windows Update detectado y revertido.')" >> %powershell_script_path%
echo            } >> %powershell_script_path%
echo        } catch { >> %powershell_script_path%
echo            Write-Log "Error al acceder o modificar la clave del registro: $_" >> %powershell_script_path%
echo        } >> %powershell_script_path%
echo        Start-Sleep -Seconds 60 >> %powershell_script_path%
echo    } >> %powershell_script_path%
echo } catch { >> %powershell_script_path%
echo    Write-Log "Ocurrio un error: $_" >> %powershell_script_path%
echo } >> %powershell_script_path%

:: Pausa para asegurar que el script PowerShell se haya escrito correctamente
timeout /t 2 /nobreak >nul

:: Crear o sobrescribir la tarea programada para ejecutar el script de monitoreo al inicio
schtasks /create /tn "MonitorWindowsUpdate" /tr "powershell.exe -ExecutionPolicy Bypass -File %powershell_script_path%" /sc onstart /rl highest /f

:: Pausa para asegurar la creación de la tarea programada
timeout /t 2 /nobreak >nul

:: Reglas de Firewall para bloquear servidores de Windows Update
netsh advfirewall firewall add rule name="Bloquear Windows Update - HTTP" dir=out protocol=TCP remoteport=80 remoteip=13.107.4.50,13.107.5.94,23.218.212.69,23.218.212.71 action=block
netsh advfirewall firewall add rule name="Bloquear Windows Update - HTTPS" dir=out protocol=TCP remoteport=443 remoteip=13.107.4.50,13.107.5.94,23.218.212.69,23.218.212.71 action=block
netsh advfirewall firewall add rule name="Bloquear Windows Update - DNS" dir=out protocol=UDP remoteport=53 remoteip=13.107.4.50,13.107.5.94,23.218.212.69,23.218.212.71 action=block
netsh advfirewall firewall add rule name="Bloquear Windows Update - Todo Trafico" dir=out protocol=any remoteip=13.107.4.50,13.107.5.94,23.218.212.69,23.218.212.71 action=block

:: Pausa para asegurar que las reglas de firewall se apliquen correctamente
timeout /t 2 /nobreak >nul

:: Configurar Firewall para Registrar Eventos de Conexion Bloqueada
netsh advfirewall set currentprofile logging droppedconnections enable

:: Pausa para asegurar la configuración del firewall
timeout /t 2 /nobreak >nul

:: Crear o sobrescribir una tarea programada para mostrar una alerta visual en intentos de conexion
schtasks /create /tn "Alerta de Conexion Bloqueada" /tr "powershell.exe -Command Add-Type -AssemblyName PresentationFramework;[System.Windows.MessageBox]::Show('Intento de conexion a Windows Update bloqueado por el firewall.')" /sc onevent /ec Security /mo *[System[(EventID=5152)]] /rl highest /f

echo Configuracion completada. Los servicios de actualizacion de Windows estan ahora monitorizados y bloqueados.

:: Mantener la ventana abierta hasta que el usuario presione una tecla
pause
