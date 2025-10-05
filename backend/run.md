# Como configurar e executar o back end  localmente
  
## Passo 1: Configurando o virtual enviroment  
No python, para evitar incompatibilidades de versão e de depedências instaladas, existem os venvs (virtual enviroments), que configura um ambiente de desenvolvimento específico interno do projeto, usando uma instalação isolada do python.

[Tutorial oficial na documentação do python](https://docs.python.org/3/library/venv.html)
Para começar, abra um terminal na pasta raiz do back-end (`mapa-adoleser/backend`) e então:
- Criar o venv:
```bash
python -m venv .venv
```
O ultimo argumento pode ser qualquer pasta desejada, mas costuma-se usar a pasta` .venv` dentro da raiz do projeto, que já será ignorada pelo gitignore do projeto e portanto não será commitada para o github.
- Ativar o venv:
	- No windows (cmd):
```cmd
.venv\Scripts\activate.bat
```
- No Linux e MacOS (e outros sistemas POSIX):
```bash
source .venv/bin/activate
```
O diretório `.venv` pode ser alterada pela pasta em que você criou o ambiente.
Agora com o venv configurado e ativo, vamos instalar todas as dependências do projeto.
## Passo 2: Instalando as dependências
Para Instalar todas as dependências há no projeto um arquivo requirements.txt que define elas e simplifica o processo, que se torna apenas a execução de um comando:
```bash
pip install -r requirements.txt
```
Com isso, se a instalação ocorrer corretamente, tudo estará pronto para executar o servidor com o Django.

## Passo 3: Executando o sistema
O Django é configurado pelo aquivo de script `manage.py`, que permite vários comandos e opções diferentes, e podem ser referenciadas na [documentação](https://docs.djangoproject.com/en/5.2/ref/django-admin/). Entretanto para executar o backend desse projeto apenas um comando é necessário:
```bash
python manage.py runserver
```
Se tudo ocorrer corretamente você terá um output como esse e o servidor estará rodando localmente na porta 8000:
```
❯ python manage.py runserver
Watching for file changes with StatReloader
Performing system checks...

System check identified no issues (0 silenced).
September 22, 2025 - 10:27:15
Django version 5.2.1, using settings 'adoleser.settings'
Starting development server at http://127.0.0.1:8000/
Quit the server with CONTROL-C.

```