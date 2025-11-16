# 🖼️ Resolver Imagens Faltando no Netlify

## Problema
As imagens não aparecem após publicar no Netlify.

## Causas Possíveis

1. **Pasta `assets/` não foi incluída no deploy**
2. **Arquivo `.gitignore` está bloqueando os arquivos**
3. **Caminho das imagens está incorreto**

## Soluções

### ✅ Solução 1: Verificar se a pasta existe no Netlify

1. No painel do Netlify, vá em **Deploys** → clique no deploy mais recente
2. Em **Deploy log**, procure por erros
3. Verifique se os arquivos `assets/` aparecem no log

### ✅ Solução 2: Fazer novo deploy com `netlify.toml`

Criei um arquivo `netlify.toml` que garante o deploy correto. Agora:

```bash
cd "c:\Aniversario da Lara"
git add netlify.toml
git commit -m "Add netlify.toml configuration"
git push
```

O Netlify vai redeploy automaticamente em poucos segundos. 🚀

### ✅ Solução 3: Força rebuild no Netlify

1. No painel do Netlify, vá em **Deploys**
2. Clique em **Trigger deploy** → **Deploy site**
3. Aguarde a conclusão

### ✅ Solução 4: Verificar `.gitignore`

Abra o arquivo `.gitignore` e certifique-se que **não** contém:
```
assets/
```

Se contiver, remova essa linha e faça push novamente.

### ✅ Solução 5: Checar permissões na pasta `assets/`

```bash
# No PowerShell, dentro da pasta do projeto:
ls -la assets/
```

Todos os arquivos devem estar lá.

## 🔍 Debug: Verificar Console do Navegador

Abra o site publicado no Netlify e:

1. Pressione **F12** (Ferramentas do Desenvolvedor)
2. Clique na aba **Console**
3. Procure por erros como:
   ```
   GET https://seu-site.netlify.app/assets/Lara1.jpg 404 (Not Found)
   ```

Se aparecer 404, significa que o arquivo não foi enviado.

## ✨ Próximos Passos

**Se nenhuma solução funcionar:**

1. Desconecte o repositório do Netlify
2. Faça um novo deploy (arrastar a pasta ou reconectar)
3. Certifique-se que **todos os arquivos** foram selecionados

---

💡 **Dica:** Você pode testar localmente com:
```bash
cd "c:\Aniversario da Lara"
.\start-server.bat
```
E abrir `http://localhost:8000` para confirmar que as imagens funcionam localmente antes de fazer deploy.
