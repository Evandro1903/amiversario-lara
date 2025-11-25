# ✅ COMO RESOLVER: Imagens Não Aparecem no Netlify

## 🔴 Problema Identificado

Os arquivos de imagem em `assets/` **NÃO ESTÃO** sendo rastreados pelo Git. Então quando você faz push, as imagens não sobem para o GitHub e o Netlify não consegue deployar.

---

## ✅ SOLUÇÃO - Execute AGORA:

### Opção 1: Limpeza Completa e Redeploy (RECOMENDADO)

**Abra PowerShell e execute:**

```powershell
cd "c:\Aniversario da Lara"

# Remover do cache do Git (mas manter os arquivos locais)
git rm -r --cached .

# Adicionar TUDO novamente (força)
git add -f .

# Verificar o que foi adicionado
git status

# Commit
git commit -m "Fix: Re-add all assets including images"

# Enviar
git push origin main
```

**Aguarde 2-5 minutos** para o Netlify fazer redeploy automático.

---

### Opção 2: Usar Script Automático

Execute o arquivo:
```
.\reinit-git.bat
```

Depois:
```
git push origin main
```

---

## 🔍 Verificar se Funcionou

### No seu computador:
```powershell
git ls-files | Select-String "Lara"
```

Deve listar:
```
assets/Lara1.jpg
assets/Lara2.jpeg
assets/Lara3.jpeg
assets/Lara4.jpeg
...
```

### No Netlify:
1. Acesse https://app.netlify.com
2. Vá em **Deploys**
3. Deve haver um novo deploy que começou
4. Espere ficar verde com **Published**
5. Visite seu site

---

## 🚀 Se Ainda Não Funcionar

Execute no PowerShell:

```powershell
# Força um rebuild completo
git push --force origin main

# No Netlify: Trigger Deploy → Deploy site (Clear cache and redeploy)
```

---

## 💡 Última Solução (Se tudo acima falhar)

Vou gerar um arquivo HTML com as imagens **embutidas** (Data URLs). As imagens virão dentro do próprio arquivo HTML.

**Avise se precisar disso!**

---

**Próximo passo:** Execute os comandos acima e espere o Netlify fazer o redeploy. 🎉
