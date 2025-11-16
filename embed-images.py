#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Script para converter imagens JPEG em Base64 e embutir no HTML
Isso garante que as imagens funcionem no Netlify sem precisar fazer upload da pasta assets/
"""

import os
import base64
from pathlib import Path

def image_to_base64(image_path):
    """Converte uma imagem em Base64"""
    with open(image_path, 'rb') as img_file:
        return base64.b64encode(img_file.read()).decode('utf-8')

def get_image_mime_type(filename):
    """Retorna o MIME type baseado na extensão"""
    if filename.lower().endswith(('.jpg', '.jpeg')):
        return 'image/jpeg'
    elif filename.lower().endswith('.svg'):
        return 'image/svg+xml'
    return 'image/jpeg'

# Caminho da pasta de assets
assets_dir = Path('assets')
print("🔍 Procurando por imagens em 'assets/'...\n")

# Dicionário para armazenar conversões
image_map = {}

# Processar imagens
for img_file in sorted(assets_dir.glob('Lara*.jpeg')) + sorted(assets_dir.glob('Lara*.jpg')):
    try:
        print(f"Convertendo: {img_file.name}...", end=" ")
        base64_data = image_to_base64(img_file)
        mime_type = get_image_mime_type(img_file.name)
        
        # Armazenar com o nome do arquivo como chave
        image_map[img_file.name] = {
            'base64': base64_data,
            'mime_type': mime_type,
            'size': len(base64_data) // 1024  # KB
        }
        
        print(f"✅ ({image_map[img_file.name]['size']} KB)")
    except Exception as e:
        print(f"❌ Erro: {e}")

print(f"\n✨ Total de imagens convertidas: {len(image_map)}\n")

# Exibir resumo
if image_map:
    print("Imagens processadas:")
    for filename, data in image_map.items():
        print(f"  - {filename}: {data['size']} KB")
    
    # Criar arquivo com código JavaScript para substituição
    js_content = """
// Substituição automática de imagens de assets/ para Base64
const imageData = {
"""
    
    for filename, data in image_map.items():
        js_content += f"""    '{filename}': 'data:{data['mime_type']};base64,{data['base64']}',
"""
    
    js_content += """};

// Substituir todos os src de imagens que começam com 'assets/Lara'
document.addEventListener('DOMContentLoaded', function() {
    document.querySelectorAll('img[src^="assets/Lara"]').forEach(img => {
        const srcPath = img.getAttribute('src');
        const filename = srcPath.split('/').pop();
        if (imageData[filename]) {
            img.setAttribute('src', imageData[filename]);
        }
    });
});
"""
    
    with open('image-embed.js', 'w', encoding='utf-8') as f:
        f.write(js_content)
    
    print("\n✅ Arquivo 'image-embed.js' criado com sucesso!")
    print("   Adicione este arquivo ao index.html antes de </body>:")
    print("   <script src=\"image-embed.js\"></script>")
else:
    print("❌ Nenhuma imagem encontrada em assets/")
