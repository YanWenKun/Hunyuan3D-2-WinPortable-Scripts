@echo off
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
    .\python_standalone\python.exe -s -m pip install "huggingface-hub[hf-transfer,cli,hf-xet]"
    if %errorlevel% equ 0 (
        echo.> ".\python_standalone\Scripts\.hf-reinstalled"
    )
)

echo Downloading models for API Server with Texture
.\python_standalone\Scripts\hf.exe download "tencent/Hunyuan3D-2" --include "hunyuan3d-paint-v2-0-turbo/**"
.\python_standalone\Scripts\hf.exe download "tencent/Hunyuan3D-2mini"

cd Hunyuan3D-2
..\python_standalone\python.exe -s api_server.py --host 0.0.0.0 --port 8081 --enable_tex

cd ..

endlocal
pause
