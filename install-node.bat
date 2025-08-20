@echo off
SETLOCAL
chcp 65001 >nul
title BootZap - Instalador Node.js

echo ========================================
echo    INSTALADOR DO NODE.JS PARA BOOTZAP
echo ========================================
echo.
echo Este instalador vai:
echo 1. Baixar Node.js 18 LTS
echo 2. Instalar automaticamente
echo 3. Configurar o ambiente
echo.
echo 📥 Baixando Node.js 18.20.1 LTS...
echo.

powershell -Command "Invoke-WebRequest -Uri 'https://nodejs.org/dist/v18.20.1/node-v18.20.1-x64.msi' -OutFile 'nodejs-installer.msi' -UserAgent 'Mozilla/5.0'"

IF EXIST "nodejs-installer.msi" (
    echo 🔄 Instalando Node.js...
    echo Aguarde, isso pode levar alguns minutos...
    echo.
    msiexec /i "nodejs-installer.msi" /quiet /norestart
    
    timeout /t 5 /nobreak >nul
    
    echo ✅ Node.js instalado com sucesso!
    echo.
    echo 📋 Verificando instalacao...
    echo.
    
    :: Atualiza variáveis de ambiente temporariamente
    FOR /F "skip=2 tokens=2,*" %%A IN ('reg query "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Environment" /v PATH 2^>nul') DO set "CURRENT_PATH=%%B"
    set "NEW_PATH=C:\Program Files\nodejs;%CURRENT_PATH%"
    
    :: Testa se node funciona
    set "PATH=%NEW_PATH%"
    node -v >nul 2>&1
    IF %ERRORLEVEL% EQU 0 (
        echo ✅ Node.js funcionando: 
        node -v
        echo ✅ npm funcionando: 
        npm -v
        echo.
        echo 🎉 Instalacao concluida com sucesso!
        echo Execute 'StartBootZap.bat' para iniciar o BootZap.
    ) ELSE (
        echo ❌ A instalacao pode precisar de reinicializacao.
        echo Reinicie o computador e execute 'StartBootZap.bat' novamente.
    )
) ELSE (
    echo ❌ Erro ao baixar Node.js!
    echo Verifique sua conexao com internet.
)

echo.
del /q "nodejs-installer.msi" 2>nul
echo Pressione qualquer tecla para fechar...
pause >nul
