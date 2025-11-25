@echo off
REM Script para verificar se os arquivos estão sendo enviados para o Git

echo.
echo === VERIFICANDO ARQUIVOS RASTREADOS ===
echo.

REM Listar arquivos no git
git ls-files | findstr "assets"

echo.
echo === VERIFICANDO ARQUIVOS NÃO RASTREADOS ===
echo.

REM Listar arquivos não rastreados
git status --short

echo.
echo === PASTA ASSETS ===
dir assets\

echo.
echo Se nao ver arquivos em "assets\" acima, execute:
echo   git add assets/
echo   git commit -m "Add image assets"
echo   git push
echo.
pause
