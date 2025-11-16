@echo off
REM Script para reinicializar o repositório Git e adicionar todos os arquivos corretamente

setlocal enabledelayedexpansion

cd /d "c:\Aniversario da Lara"

echo.
echo ========================================
echo   REINICIALIZANDO REPOSITÓRIO GIT
echo ========================================
echo.

REM Listar arquivos atuais
echo [Arquivos no diretório:]
dir /b /s *.jpg *.jpeg *.svg 2>nul | findstr /v ".git"

echo.
echo [1/5] Verificando configuração global do Git...
git config --global core.longpaths true
echo ✓ Long paths habilitados

echo.
echo [2/5] Removendo .gitignore temporariamente para diagnosticar...
if exist ".gitignore" (
    ren ".gitignore" ".gitignore.bak"
    echo ✓ .gitignore renomeado para .gitignore.bak
)

echo.
echo [3/5] Limpando cache do Git...
git rm -r --cached . >nul 2>&1
echo ✓ Cache limpo

echo.
echo [4/5] Adicionando todos os arquivos (forçado)...
git add -f .
git status

echo.
echo [5/5] Fazendo commit...
git commit -m "Reinitialize repository with all assets"

echo.
echo ========================================
echo.
echo ✅ Pronto! Agora execute:
echo    git push origin main
echo.
pause
