#!/usr/bin/env bash

# Uso e validação
if [ -z "$1" ]; then
    echo "Uso: $0 nome_da_estrutura"
    exit 1
fi

STRUCTURE_NAME="$1"

# Normaliza nome do pacote (minúsculas, underscores no lugar de espaços)
PACKAGE_NAME=$(echo "$STRUCTURE_NAME" | tr '[:upper:]' '[:lower:]' | tr ' ' '_' | sed 's/[^a-z0-9_\-]/_/g')

if [ -d "$STRUCTURE_NAME" ]; then
    echo "Diretório '$STRUCTURE_NAME' já existe. Abortando para evitar sobrescrita."
    exit 1
fi

set -euo pipefail

# Cria estrutura básica
mkdir -p "$STRUCTURE_NAME/$PACKAGE_NAME"
cat > "$STRUCTURE_NAME/$PACKAGE_NAME/__init__.py" <<EOF
# $PACKAGE_NAME package
__version__ = "0.0.1"
EOF

cat > "$STRUCTURE_NAME/$PACKAGE_NAME/core.py" <<EOF
# $PACKAGE_NAME/core.py
def hello_world():
    return "Hello, world!"
EOF

mkdir -p "$STRUCTURE_NAME/tests"
cat > "$STRUCTURE_NAME/tests/test_core.py" <<EOF
import pytest
import sys
import os
sys.path.insert(0, os.path.abspath(os.path.join(os.path.dirname(__file__), '..')))
from $PACKAGE_NAME.core import hello_world

def test_hello_world():
    assert hello_world() == "Hello, world!"
EOF

# README com instruções em português
cat > "$STRUCTURE_NAME/README.md" <<EOF
# ${STRUCTURE_NAME^}

Pequena biblioteca de exemplo gerada por `setup.sh`.

Instalação
```sh
python -m pip install .
# ou para desenvolvimento
python -m pip install -e .
```

Uso
```py
from ${PACKAGE_NAME} import hello_world
print(hello_world())
```

EOF

# Cria pyproject.toml (PEP 621 / setuptools backend)
cat > "$STRUCTURE_NAME/pyproject.toml" <<EOF
[build-system]
requires = ["setuptools>=61.0", "wheel"]
build-backend = "setuptools.build_meta"

[project]
name = "${PACKAGE_NAME}"
version = "0.0.1"
description = "Descricao da sua lib ${STRUCTURE_NAME}"
readme = "README.md"
authors = [ { name = "Seu Nome", email = "seu.email@example.com" } ]
license = { text = "MIT" }
requires-python = ">=3.8"
keywords = ["example", "library"]
classifiers = [
    "Programming Language :: Python :: 3",
    "License :: OSI Approved :: MIT License",
    "Operating System :: OS Independent",
]

EOF

# LICENSE (MIT - Português + English)
cat > "$STRUCTURE_NAME/LICENSE" <<EOF
====================
LICENÇA MIT (Português)
====================

Copyright (c) $(date +%Y) Seu Nome

Permissão é concedida, gratuitamente, a qualquer pessoa que obtenha uma cópia
deste software e dos arquivos de documentação associados (o "Software"), para
lidar com o Software sem restrições, incluindo sem limitação os direitos de
usar, copiar, modificar, mesclar, publicar, distribuir, sublicenciar e/ou vender
cópias do Software, e permitir que pessoas a quem o Software for fornecido o
façam, mediante as seguintes condições:
todas as cópias ou partes substanciais do Software.

O SOFTWARE É FORNECIDO "NO ESTADO EM QUE SE ENCONTRA", SEM GARANTIA DE QUALQUER
ESPÉCIE, EXPRESSA OU IMPLÍCITA, INCLUINDO, MAS NÃO SE LIMITANDO ÀS GARANTIAS DE
COMERCIALIZAÇÃO, ADEQUAÇÃO A UMA FINALIDADE ESPECÍFICA E NÃO VIOLAÇÃO. EM NENHUM
CASO OS AUTORES OU DETENTORES DOS DIREITOS SERÃO RESPONSÁVEIS POR QUAISQUER
REIVINDICAÇÕES, DANOS OU OUTRAS RESPONSABILIDADES, SEJA EM UMA AÇÃO DE
CONTRATO, ATO ILÍCITO OU OUTRA FORMA, DECORRENTES DE, FORA DE OU EM CONEXÃO
COM O SOFTWARE OU O USO OU OUTRAS NEGOCIAÇÕES NO SOFTWARE.

====================
MIT LICENSE (English)
====================

MIT License

Copyright (c) $(date +%Y) Seu Nome

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
EOF

echo "Estrutura '$STRUCTURE_NAME' criada com sucesso!"
echo "Entre em '$STRUCTURE_NAME' e rode: python -m pip install -e . e pytest para testar."