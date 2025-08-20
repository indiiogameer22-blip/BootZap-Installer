@echo off
SETLOCAL
chcp 65001 >nul
title BootZap - Inicializador

echo ========================================
echo          INICIANDO BOOTZAP
echo ========================================
echo.

:: Verifica se Node.js está instalado
node -v >nul 2>&1
IF %ERRORLEVEL% NEQ 0 (
    echo ❌ Node.js nao encontrado!
    echo.
    echo Para instalar o Node.js automaticamente:
    echo 1. Feche esta janela
    echo 2. Execute o arquivo 'install-node.bat'
    echo 3. Depois execute este arquivo novamente
    echo.
    pause
    exit /b 1
)

:: Verifica se npm está instalado
npm -v >nul 2>&1
IF %ERRORLEVEL% NEQ 0 (
    echo ❌ npm nao encontrado!
    echo A instalacao do Node.js pode estar incompleta.
    echo.
    echo Execute 'install-node.bat' para reinstalar.
    echo.
    pause
    exit /b 1
)

echo ✅ Node.js encontrado: 
node -v
echo ✅ npm encontrado: 
npm -v
echo.

:: Instala dependências na primeira execução
IF NOT EXIST "node_modules" (
    echo 📦 Instalando dependencias (primeira execucao)...
    echo Isso pode levar alguns minutos...
    echo.
    npm install --silent
    IF %ERRORLEVEL% NEQ 0 (
        echo ❌ Erro ao instalar dependencias!
        echo.
        pause
        exit /b 1
    )
    echo ✅ Dependencias instaladas com sucesso!
    echo.
)

:: Inicia o BootZap
echo 🚀 Iniciando BootZap...
echo ========================================
echo.
npm start

echo.
echo ========================================
echo BootZap finalizado. Pressione qualquer tecla para fechar.
pause >nul
