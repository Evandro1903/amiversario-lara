@echo off
REM Script para forçar adicionar arquivos à pasta assets e fazer push

echo.
echo ========================================
echo   ADICIONANDO ARQUIVOS AO GIT
echo ========================================
echo.

cd /d "c:\Aniversario da Lara"

REM Forçar adicionar todos os arquivos, inclusive imagens grandes
echo [1/4] Adicionando arquivos da pasta assets...
git add -f assets/

echo [2/4] Verificando status...
git status

echo.
echo [3/4] Fazendo commit...
git commit -m "Add image assets - Fix Netlify deployment"

echo.
echo [4/4] Fazendo push para repositório remoto...
git push

echo.
echo ========================================
echo   CONCLUÍDO!
echo ========================================
echo.
echo Aguarde 2-3 minutos para o Netlify fazer o redeploy automaticamente.
echo.
pause
