#!/bin/bash
# Script para executar o Labirinto Genetico no Linux/macOS
# ======================================================

if [ ! -f labirinto_genetico ]; then
    echo "[ERRO] Executavel nao encontrado!"
    echo "Execute './build.sh' primeiro para compilar o projeto."
    exit 1
fi

if [ -z "$1" ]; then
    # Usar configuracao padrao
    echo "Executando com configuracao padrao (sem DVP)..."
    echo ""
    ./labirinto_genetico configsemdvp.ini Mapas/maze.txt
else
    # Usar argumentos fornecidos
    echo "Executando com argumentos: $@"
    echo ""
    ./labirinto_genetico "$@"
fi

echo ""
echo "Execucao finalizada. Verifique Logs/ para os resultados."
