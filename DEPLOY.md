# 🚀 Como Publicar no GitHub Pages

## Passo 1: Preparar Repositório Local

Abra PowerShell na pasta do projeto e execute:

```powershell
cd "c:\Aniversario da Lara"
git init
git config user.name "Seu Nome"
git config user.email "seu.email@gmail.com"
git add .
git commit -m "Initial commit: Lara's 15th birthday invitation"
```

## Passo 2: Criar Repositório no GitHub

1. Acesse: https://github.com/new
2. **Repository name**: `aniversario-lara`
3. **Description**: "Convite de aniversário de 15 anos - Tema Borboletas"
4. Marque **Public**
5. Clique **Create repository**

## Passo 3: Conectar e Fazer Push

Copie o comando do GitHub (ou execute abaixo, substituindo `SEU_USUARIO`):

```powershell
git branch -M main
git remote add origin https://github.com/SEU_USUARIO/aniversario-lara.git
git push -u origin main
```

## Passo 4: Ativar GitHub Pages

1. No repositório, clique em **Settings** (ícone de engrenagem)
2. Na esquerda, clique em **Pages**
3. Em **Source**, selecione **main**
4. Em **Folder**, selecione **/ (root)**
5. Clique **Save**
6. Aguarde ~2 minutos

## ✅ Pronto!

Seu site estará publicado em:
```
https://SEU_USUARIO.github.io/aniversario-lara
```

Compartilhe este link com os convidados! 🎉

---

**Dúvidas?** Veja: https://docs.github.com/pt/pages
