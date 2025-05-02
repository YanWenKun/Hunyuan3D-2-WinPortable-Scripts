@echo off
setlocal enabledelayedexpansion
chcp 65001

:: 获取上上级目录路径
for %%i in ("%~dp0..\..") do set "upper_dir=%%~fi"

:: 检查上上级目录是否存在
if not exist "%upper_dir%" (
    echo 错误：上上级目录不存在 - "%upper_dir%"
    pause
    exit /b 1
)

:: 直接列出要复制的文件（每行一个，用引号括起来）
for %%f in (
    "1-编译安装纹理生成功能.bat"
    "2-下载模型.bat"
    "3-启动.bat"
    "4-启动_MV多视图.bat"
    "5-启动_API服务模式.bat"
    "6-启动_API服务模式_带纹理功能.bat"
    "更新.bat"
    "运行_MV多视图_大显存模式.bat"
    "运行_大显存模式.bat"
    "运行_超低显存模式.bat"
    "运行_带文生3D.bat"
) do (
    if exist "%%~f" (
        echo 正在复制: "%%~f" 到 "%upper_dir%\"
        copy /y "%%~f" "%upper_dir%\" >nul
        if errorlevel 1 (
            echo 错误：复制 "%%~f" 失败
            set error_occurred=1
        )
    ) else (
        echo 错误：文件 "%%~f" 不存在
        set error_occurred=1
    )
)

:: 检查是否有错误发生
if defined error_occurred (
    echo 错误：文件复制过程中发生错误，操作已终止
) else (
    echo 所有文件已成功复制，操作结束
)

endlocal
pause
