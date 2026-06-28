@echo off
REM Script para executar o Labirinto Genetico no Windows
REM ====================================================

if not exist labirinto_genetico.exe (
    echo [ERRO] Executavel nao encontrado!
    echo Execute 'build.bat' primeiro para compilar o projeto.
    exit /b 1
)

if "%1"=="" (
    REM Usar configuracao padrao
    echo Executando com configuracao padrao (sem DVP)...
    echo.
    labirinto_genetico.exe configsemdvp.ini Mapas/maze.txt
) else (
    REM Usar argumentos fornecidos
    echo Executando com argumentos: %*
    echo.
    labirinto_genetico.exe %*
)

echo.
echo Execucao finalizada. Verifique Logs\ para os resultados.
