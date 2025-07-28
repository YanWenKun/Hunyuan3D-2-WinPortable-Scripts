@echo on
setlocal

@REM To set proxy, edit and uncomment the two lines below (remove 'rem ' in the beginning of line).
rem set HTTP_PROXY=http://localhost:1080
rem set HTTPS_PROXY=http://localhost:1080

@REM ===========================================================================
@REM These settings usually don't need change.

@REM This command will set PATH environment variable.
set PATH=%PATH%;%~dp0\MinGit\cmd;%~dp0\python_standalone\Scripts

@REM This command will let the .pyc files to be stored in one place.
set PYTHONPYCACHEPREFIX=%~dp0\pycache

@REM This command redirects HuggingFace-Hub to download model files in this folder.
set HF_HUB_CACHE=%~dp0\HuggingFaceHub
set HY3DGEN_MODELS=%~dp0\HuggingFaceHub

@REM ===========================================================================

@REM Reinstall hf-hub
if not exist ".\python_standalone\Scripts\.hf-reinstalled" (
    echo Reinstalling huggingface-hub...
    .\python_standalone\python.exe -s -m pip uninstall --yes huggingface-hub
    .\python_standalone\python.exe -s -m pip install "huggingface-hub[hf-transfer]"
    if %errorlevel% equ 0 (
        echo.> ".\python_standalone\Scripts\.hf-reinstalled"
    )
)

echo Downloading Hunyuan3D-2.1 model files...
.\python_standalone\Scripts\huggingface-cli.exe download ^
"tencent/Hunyuan3D-2.1" --include "hunyuan3d-dit-v2-1/**"

cd Hunyuan3D-2
..\python_standalone\python.exe -s gradio_app.py --model_path "tencent\Hunyuan3D-2.1" --subfolder "hunyuan3d-dit-v2-1"

cd ..

endlocal
pause
