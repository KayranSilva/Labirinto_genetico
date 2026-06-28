@echo off
REM Script para compilar o projeto no Windows
REM ============================================

echo Compilando Labirinto Genetico...
gcc -Wall -Wextra -std=c99 -lm -O2 -o labirinto_genetico.exe main.c config.c genetic.c individual.c maze.c

if %errorlevel% equ 0 (
    echo.
    echo [OK] Compilacao bem-sucedida!
    echo [OK] Executavel: labirinto_genetico.exe
    echo.
    echo Para executar:
    echo   labirinto_genetico.exe [config] [mapa]
    echo.
    echo Exemplos:
    echo   labirinto_genetico.exe configsemdvp.ini Mapas/maze.txt
    echo   labirinto_genetico.exe configcomdvp.ini Mapas/maze2.txt
) else (
    echo.
    echo [ERRO] Falha na compilacao!
    exit /b 1
)
