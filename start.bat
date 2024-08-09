@echo off
:: Configurar las variables
setlocal enabledelayedexpansion

:: Limpiar la pantalla
cls

:: Mostrar el arte ASCII de la palmera en la playa con el ocaso
echo                          .sS$$$$$$$$$$$$$Ss.
echo                        .sS$$$$$$$$$$$$$$$$$Ss.
echo                       .$$.$$$$$$$$$$$$$$$$$$$$s.
echo                      .$$$:$$$$$$$$$$$$$$$$$$$$$$Ss.
echo                    .$$$.'$$$$$$$$;~' `~~~~~~C$$$$$$s.
echo                  .$'$$:$$$$$$$$"'            `"$$$$$S.
echo               .S$$:$$:$$$$$$$'             _    `$$$$$s.
echo             .S$$:$$:$$$$$£$$'        __--~~  _    $$$$$$.
echo            .$$$$:$$:$$$$$$$'     _.-~    _.-~     `$$$$$$$.
echo          .$$$$$:$$:$$$$$$$'    -~    _.-~           `$$$$$$.
echo         .$$$$:$$:$$$$$$$$'    _.--~         ..s$$$$S.$$$$$$$s.
echo        .$$$$$:$$$:$$$$$$$     _..._        .$$$SSSSSS$$$$$$$$$.
echo       .$$$$$:$$$$:$$$$$$$    ~.sggg.        "  .~(g )$$$$$$$$$$.
echo       $$$$$:$$$$$:$$$$$$$ .sS$$$$$$$$s.     : '"--"' `$$$$$$$$$$.
echo       `$$$:$$$$$$:$$$$$$$.$$" .. g"-. `.    `.-.._    `$$$$$$$$$$
echo        $$$:$$$$$$:$$$$$$$`$' ' `._.'   :      `---      $$$$$$$$$.
echo        $$$:.$$$$$:$$$$$$$    `---'  _.'                 $$$$$$$$$$$.
echo        $$$$$:$$$$:$$$$$$s      ----"           .        $$$$$$$$$$$$.
echo        $$$$$`.~$$:$$$$$$$.                      `-._   .$$$$$$$$$$$$$$Sss.
echo        $$$$$$`;$$:$$$$$$$$.         _.:         .'   ;  $$$$$$$$$$$$$$$$$$$.
echo       .s$$$$$$`$$`.$$$$$$$$.      .'  `.       ' _ .`.  $$$$$$$$$$$$$$$$$$$$Ss.
echo     .s$$$$$$$$$$$$:$$$$$$$$$     :  _   ~~-...'.'.'  :  $$$$$$$$$$$$$$$$$$$$$$$
echo   .s$$$$$$$$$$$$$$`.$$$$$$$$s      : .~-,-.-.~:.'   :  $$$$$$$$$$$$$$$$$$$$$$
echo .s$$$$$$$$$$$$$$$$$`$$$$$$$$$$.    `  ~-.`""".'      `.$$$$$$$$$$$$$$$$$$$'
echo $$$$$$$$$$$$$$$$$$$$$$$$$$$$$$S.   .      `""'        $$$$$$$$$$$$$$$$$$'
echo $$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$S. `.                 $$$$$$$$$$$$$$$$'
echo $$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$Ss.`.              .$$$$$$$$$$$$$$'
echo $$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$Ss.          .s$$$$$$$$$$$$'
echo $$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$Ss......sS$$$$$$$$$$$'
echo $$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$'
echo $$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$'
echo $$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$'

echo.
echo Que comience el juego!

:: Contador regresivo
set countdown=5

:countdown_loop
cls
echo                          .sS$$$$$$$$$$$$$Ss.
echo                        .sS$$$$$$$$$$$$$$$$$Ss.
echo                       .$$.$$$$$$$$$$$$$$$$$$$$s.
echo                      .$$$:$$$$$$$$$$$$$$$$$$$$$$Ss.
echo                    .$$$.'$$$$$$$$;~' `~~~~~~C$$$$$$s.
echo                  .$'$$:$$$$$$$$"'            `"$$$$$S.
echo               .S$$:$$:$$$$$$$'             _    `$$$$$s.
echo             .S$$:$$:$$$$$£$$'        __--~~  _    $$$$$$.
echo            .$$$$:$$:$$$$$$$'     _.-~    _.-~     `$$$$$$$.
echo          .$$$$$:$$:$$$$$$$'    -~    _.-~           `$$$$$$.
echo         .$$$$:$$:$$$$$$$$'    _.--~         ..s$$$$S.$$$$$$$s.
echo        .$$$$$:$$$:$$$$$$$     _..._        .$$$SSSSSS$$$$$$$$$.
echo       .$$$$$:$$$$:$$$$$$$    ~.sggg.        "  .~(g )$$$$$$$$$$.
echo       $$$$$:$$$$$:$$$$$$$ .sS$$$$$$$$s.     : '"--"' `$$$$$$$$$$.
echo       `$$$:$$$$$$:$$$$$$$.$$" .. g"-. `.    `.-.._    `$$$$$$$$$$
echo        $$$:$$$$$$:$$$$$$$`$' ' `._.'   :      `---      $$$$$$$$$.
echo        $$$:.$$$$$:$$$$$$$    `---'  _.'                 $$$$$$$$$$$.
echo        $$$$$:$$$$:$$$$$$s      ----"           .        $$$$$$$$$$$$.
echo        $$$$$`.~$$:$$$$$$$.                      `-._   .$$$$$$$$$$$$$$Sss.
echo        $$$$$$`;$$:$$$$$$$$.         _.:         .'   ;  $$$$$$$$$$$$$$$$$$$.
echo       .s$$$$$$`$$`.$$$$$$$$.      .'  `.       ' _ .`.  $$$$$$$$$$$$$$$$$$$$Ss.
echo     .s$$$$$$$$$$$$:$$$$$$$$$     :  _   ~~-...'.'.'  :  $$$$$$$$$$$$$$$$$$$$$$$
echo   .s$$$$$$$$$$$$$$`.$$$$$$$$s      : .~-,-.-.~:.'   :  $$$$$$$$$$$$$$$$$$$$$$
echo .s$$$$$$$$$$$$$$$$$`$$$$$$$$$$.    `  ~-.`""".'      `.$$$$$$$$$$$$$$$$$$$'
echo $$$$$$$$$$$$$$$$$$$$$$$$$$$$$$S.   .      `""'        $$$$$$$$$$$$$$$$$$'
echo $$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$S. `.                 $$$$$$$$$$$$$$$$'
echo $$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$Ss.`.              .$$$$$$$$$$$$$$'
echo $$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$Ss.          .s$$$$$$$$$$$$'
echo $$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$Ss......sS$$$$$$$$$$$'
echo $$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$'
echo $$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$'
echo $$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$'
echo.
echo Iniciando en: !countdown!...
timeout /t 1 >nul
set /a countdown-=1
if !countdown! geq 0 goto countdown_loop

:: Ejecutar los archivos .bat en el mismo directorio
start "" "%~dp0deactivate.bat"
start "" "%~dp0monitor.bat"

:: Mantener la ventana abierta
pause
