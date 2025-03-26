@echo off
setlocal enabledelayedexpansion

:: Get the parent directory's parent (two levels up)
for %%i in ("%~dp0..\..") do set "upper_dir=%%~fi"

:: Check if target directory exists
if not exist "%upper_dir%" (
    echo ERROR: Target directory does not exist - "%upper_dir%"
    pause
    exit /b 1
)

:: List files to copy (one per line, quoted for spaces/Chinese)
for %%f in (
    "1-compile-install-texture-gen.bat"
    "2-download-models.bat"
    "3-start.bat"
    "4-start-mv.bat"
    "UPDATE.bat"
    "run-very_low_vram.bat"
    "run-with-text_to_3d.bat"
) do (
    if exist "%%~f" (
        echo Copying: "%%~f" to "%upper_dir%\"
        copy /y "%%~f" "%upper_dir%\" >nul
        if errorlevel 1 (
            echo ERROR: Failed to copy "%%~f"
            set error_occurred=1
        )
    ) else (
        echo ERROR: File "%%~f" not found
        set error_occurred=1
    )
)

:: Error handling
if defined error_occurred (
    echo ERROR: Operation terminated due to errors
) else (
    echo All files copied successfully. Operation complete.
)

endlocal
pause
