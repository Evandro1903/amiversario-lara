# Script para converter imagens em Base64 e embutir no HTML
# Uso: .\create-embedded-html.ps1

param(
    [string]$InputHtml = "index.html",
    [string]$OutputHtml = "index-embedded.html"
)

Write-Host "🖼️  Gerando HTML com imagens embutidas..." -ForegroundColor Cyan
Write-Host ""

# Função para converter arquivo em Base64
function ConvertTo-Base64 {
    param([string]$FilePath)
    
    if (-not (Test-Path $FilePath)) {
        Write-Host "❌ Arquivo não encontrado: $FilePath" -ForegroundColor Red
        return $null
    }
    
    $bytes = [System.IO.File]::ReadAllBytes($FilePath)
    return [Convert]::ToBase64String($bytes)
}

# Ler HTML original
if (-not (Test-Path $InputHtml)) {
    Write-Host "❌ $InputHtml não encontrado!" -ForegroundColor Red
    exit
}

$htmlContent = Get-Content $InputHtml -Raw -Encoding UTF8

# Mapa de substituições
$replacements = @{
    "assets/Lara1.jpg"    = "Lara1.jpg"
    "assets/Lara2.jpeg"   = "Lara2.jpeg"
    "assets/Lara3.jpeg"   = "Lara3.jpeg"
    "assets/Lara4.jpeg"   = "Lara4.jpeg"
    "assets/Lara6.jpeg"   = "Lara6.jpeg"
    "assets/Lara9.jpeg"   = "Lara9.jpeg"
    "assets/butterfly.svg" = "butterfly.svg"
}

# Processar cada imagem
foreach ($srcPath in $replacements.Keys) {
    $fileName = $replacements[$srcPath]
    $filePath = "assets\$fileName"
    
    if (Test-Path $filePath) {
        Write-Host "Convertendo: $fileName ... " -NoNewline
        
        $base64 = ConvertTo-Base64 $filePath
        
        if ($base64) {
            # Determinar MIME type
            if ($fileName -match "\.jpe?g$") {
                $mimeType = "image/jpeg"
            } elseif ($fileName -match "\.svg$") {
                $mimeType = "image/svg+xml"
            } else {
                $mimeType = "image/jpeg"
            }
            
            $dataUrl = "data:$mimeType;base64,$base64"
            $htmlContent = $htmlContent -replace [regex]::Escape($srcPath), $dataUrl
            
            Write-Host "✅" -ForegroundColor Green
        } else {
            Write-Host "❌" -ForegroundColor Red
        }
    } else {
        Write-Host "$fileName não encontrado (pulando)" -ForegroundColor Yellow
    }
}

# Salvar HTML com imagens embutidas
$htmlContent | Out-File $OutputHtml -Encoding UTF8

Write-Host ""
Write-Host "✅ Arquivo gerado: $OutputHtml" -ForegroundColor Green
Write-Host ""
Write-Host "Próximos passos:" -ForegroundColor Cyan
Write-Host "  1. Renomear $OutputHtml para index.html"
Write-Host "  2. Fazer commit e push:"
Write-Host "     git add index.html"
Write-Host "     git commit -m 'Embed images in HTML for Netlify'"
Write-Host "     git push"
Write-Host ""
