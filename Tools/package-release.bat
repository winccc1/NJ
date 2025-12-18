@echo off
setlocal

rem Build and gather Release executables for VMGuide GUI and CLI
for %%I in ("%~dp0..") do set "SOLUTION_ROOT=%%~fI"
set "OUTPUT_DIR=%SOLUTION_ROOT%\dist"
set "CONFIGURATION=Release"
set "PLATFORM=Any CPU"

if exist "%OUTPUT_DIR%" rmdir /s /q "%OUTPUT_DIR%"
mkdir "%OUTPUT_DIR%" || goto :error

echo Building solution in %CONFIGURATION% mode...
msbuild "%SOLUTION_ROOT%\VMGuide.sln" /t:Clean;Build /p:Configuration=%CONFIGURATION% /p:Platform="%PLATFORM%" || goto :error

echo Copying GUI artifacts...
set "GUI_BIN=%SOLUTION_ROOT%\VMGuide.GUI\bin\%CONFIGURATION%"
if not exist "%GUI_BIN%" (
    echo GUI build output not found at %GUI_BIN%
    goto :error
)
mkdir "%OUTPUT_DIR%\GUI" || goto :error
xcopy "%GUI_BIN%\*" "%OUTPUT_DIR%\GUI\" /s /i /y >nul || goto :error

echo Copying CLI artifacts...
set "CUI_BIN=%SOLUTION_ROOT%\VMGuide.CUI\bin\%CONFIGURATION%"
if not exist "%CUI_BIN%" (
    echo CLI build output not found at %CUI_BIN%
    goto :error
)
mkdir "%OUTPUT_DIR%\CUI" || goto :error
xcopy "%CUI_BIN%\*" "%OUTPUT_DIR%\CUI\" /s /i /y >nul || goto :error

echo Creating zip archives for distribution...
powershell -NoLogo -NoProfile -Command "Compress-Archive -Path '%OUTPUT_DIR%\GUI\*' -DestinationPath '%OUTPUT_DIR%\VMGuide.GUI.zip' -Force" || goto :error
powershell -NoLogo -NoProfile -Command "Compress-Archive -Path '%OUTPUT_DIR%\CUI\*' -DestinationPath '%OUTPUT_DIR%\VMGuide.CUI.zip' -Force" || goto :error

echo.
echo Package generated under %OUTPUT_DIR%
exit /b 0

:error
echo.
echo Failed to build or package the executables.
exit /b 1
