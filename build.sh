#!/bin/bash
# Script para compilar o projeto no Linux/macOS
# =============================================

echo "Compilando Labirinto Genetico..."
gcc -Wall -Wextra -std=c99 -lm -O2 -o labirinto_genetico main.c config.c genetic.c individual.c maze.c

if [ $? -eq 0 ]; then
    echo ""
    echo "[OK] Compilacao bem-sucedida!"
    echo "[OK] Executavel: labirinto_genetico"
    echo ""
    echo "Para executar:"
    echo "  ./labirinto_genetico [config] [mapa]"
    echo ""
    echo "Exemplos:"
    echo "  ./labirinto_genetico configsemdvp.ini Mapas/maze.txt"
    echo "  ./labirinto_genetico configcomdvp.ini Mapas/maze2.txt"
else
    echo ""
    echo "[ERRO] Falha na compilacao!"
    exit 1
fi
