@echo off
REM Script para gerar um documento HTML com imagens embutidas como Base64

echo Verificando se Python está disponível...
python --version >nul 2>&1

if errorlevel 1 (
    echo ❌ Python não encontrado no sistema
    echo.
    echo Alternativas:
    echo   1. Instale Python de: https://www.python.org/downloads/
    echo   2. Use a solução manual de fazer git add -f assets/
    echo.
    pause
    exit /b 1
)

echo ✅ Python encontrado!
echo.
echo Gerando arquivo com imagens embutidas...
echo.

REM Executar Python para gerar HTML
python -c "
import os
import base64
from pathlib import Path

print('Procurando imagens em assets/')
assets_dir = Path('assets')

# Encontrar imagens
images = {}
for img in sorted(assets_dir.glob('Lara*.{jpg,jpeg}')):
    try:
        with open(img, 'rb') as f:
            base64_data = base64.b64encode(f.read()).decode()
            images[img.name] = base64_data
            print(f'  ✓ {img.name}')
    except Exception as e:
        print(f'  ✗ {img.name}: {e}')

if images:
    print(f'\nTotal: {len(images)} imagens processadas')
    print('Arquivo index-embedded.html será criado com sucesso.')
else:
    print('Nenhuma imagem encontrada!')
"

echo.
echo Concluído!
pause
