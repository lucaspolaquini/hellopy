# Publicando uma biblioteca Python no PyPI

Este README descreve o processo de criar uma biblioteca Python, empacotar e enviar para o PyPI usando Twine.

## 1. Pré-requisitos

- Python 3 instalado
- acesso à internet
- conta no PyPI

## 2. Criar ambiente virtual

No diretório do projeto:

```sh
python3 -m venv .venv
source .venv/bin/activate
```

## 3. Instalar pacotes necessários

Dentro do ambiente virtual:

```sh
pip install --upgrade pip setuptools wheel twine
```

## 4. Estrutura básica do projeto

Com base no `setup.sh`, a estrutura mínima do projeto deve ter:

- `hellopy/` ou `<nome_projeto>/`
  - `__init__.py`
  - `core.py`
- `tests/`
  - `test_core.py`
- `setup.py`
- `README.md` ou `readme.md`

Exemplo do `setup.sh` existente:

```sh
mkdir -p $STRUCTURE_NAME/$STRUCTURE_NAME
touch $STRUCTURE_NAME/$STRUCTURE_NAME/__init__.py
```

O script também cria:

- `tests/test_core.py`
- `setup.py`
- `README.md`

## 5. Variáveis importantes do `setup.py`

No seu `setup.py`, as variáveis principais são:

- `name`: nome do pacote no PyPI, por exemplo `hellopy-package`
- `version`: versão do pacote, por exemplo `1.0.0`
- `packages`: pacotes a incluir, geralmente `find_packages()`
- `description`: descrição curta da biblioteca
- `author`: nome do autor
- `author_email`: email de contato
- `url`: URL do repositório ou da página do projeto
- `license`: licença do projeto, por exemplo `MIT`
- `long_description`: descrição longa, geralmente lida de `README.md`
- `long_description_content_type`: tipo do README, por exemplo `text/markdown`

## 6. Gerar o pacote

Execute:

```sh
python3 setup.py sdist bdist_wheel
```

Isso cria os arquivos em `dist/`.

## 7. Obter o token do PyPI

No site do PyPI, crie um token em:

https://pypi.org/manage/account/token/

Esse token é usado no lugar da sua senha.

## 8. Configurar token globalmente

Para não precisar informar o token toda vez, crie o arquivo `$HOME/.pypirc` com:

```ini
[distutils]
index-servers =
    pypi

[pypi]
username = __token__
password = pypi-xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
```

> O arquivo deve estar em `$HOME/.pypirc` para o Twine encontrá-lo automaticamente.
> Se estiver em outro local, use `twine upload --config-file /caminho/para/.pypirc dist/*`.

## 9. Fazer upload para o PyPI

Depois de gerar os pacotes:

```sh
twine upload dist/*
```

## 10. Confirmar publicação

Após o upload, o Twine retorna uma saída com a URL do pacote. Exemplo:

```text
View at:
https://pypi.org/project/hellopy-package/1.0.0/
```

Pronto! A biblioteca já estará publicada no PyPI.