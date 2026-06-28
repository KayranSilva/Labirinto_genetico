# 🧬 Algoritmo Genético para Resolução de Labirintos

Um projeto em **C** que implementa um algoritmo genético para encontrar o caminho de saída em labirintos de forma automática.

## 📋 Índice

- [Visão Geral](#visão-geral)
- [Características](#características)
- [Requisitos](#requisitos)
- [Instalação](#instalação)
- [Como Usar](#como-usar)
- [Configuração](#configuração)
- [Estrutura do Projeto](#estrutura-do-projeto)
- [Formato do Labirinto](#formato-do-labirinto)
- [Parâmetros Genéticos](#parâmetros-genéticos)
- [Exemplos](#exemplos)
- [Autores](#autores)

---

## 🎯 Visão Geral

Este projeto utiliza **Algoritmos Genéticos** para encontrar a rota mais eficiente em um labirinto. Cada "indivíduo" representa uma sequência de movimentos:

| Código | Movimento |
|--------|-----------|
| **C**  | Cima (↑)  |
| **B**  | Baixo (↓) |
| **E**  | Esquerda (←) |
| **D**  | Direita (→) |

A população evolui através de gerações usando **seleção por torneio**, **cruzamento** e **mutação** até encontrar uma solução.

---

## ✨ Características

✅ **Algoritmo Genético Completo**
- Seleção por torneio
- Cruzamento de dois pontos (2-point crossover)
- Mutação adaptativa
- Elitismo (preservação dos melhores)

✅ **Funcionalidades**
- Leitura dinâmica de labirintos
- Configuração por arquivo `.ini`
- Registro em log (CSV) da evolução
- Visualização animada do melhor caminho encontrado
- Detecção automática de dimensões do labirinto

✅ **Flexibilidade**
- Múltiplas configurações pré-definidas
- Suporte a diferentes tamanhos de labirinto
- Parâmetros totalmente configuráveis

---

## 📦 Requisitos

- **Compilador C**: GCC, Clang ou compatível
- **Sistema Operacional**: Linux, macOS ou Windows (com MinGW/MSYS2)
- **Make** (opcional, mas recomendado)

### Verificar se você tem os requisitos:

```bash
# Verificar GCC
gcc --version

# Verificar Make (opcional)
make --version
```

---

## 🔧 Instalação

### 1️⃣ **Clonar ou Baixar o Projeto**

```bash
git clone https://github.com/KayranSilva/Labirinto_genetico.git
cd Labirinto_genetico
```

### 2️⃣ **Compilar o Projeto**

#### **Opção A: Usando Make (Recomendado)**

```bash
make clean-all    # Limpar compilações anteriores
make              # Compilar o projeto
```

#### **Opção B: Compilação Manual (Windows/Linux/macOS)**

```bash
gcc -Wall -Wextra -std=c99 -lm -O2 -o bin/labirinto_genetico \
    main.c config.c genetic.c individual.c maze.c
```

---

## 🚀 Como Usar

### **Execução Básica**

Após compilar, execute com:

```bash
./bin/labirinto_genetico
```

Isso usará a configuração padrão: `configuracoes/config.ini`

### **Execução com Argumentos**

Você pode especificar a configuração e o mapa:

```bash
./bin/labirinto_genetico [config.ini] [caminho_mapa.txt]
```

**Exemplos:**

```bash
# Usar configuração sem DVP
./bin/labirinto_genetico configsemdvp.ini Mapas/maze.txt

# Usar configuração com DVP
./bin/labirinto_genetico configcomdvp.ini Mapas/maze2.txt
```

### **Usando Make para Executar**

```bash
# Executar com configuração padrão
make run

# Executar com DVP
make run-dvp
```

---

## ⚙️ Configuração

As configurações são carregadas de arquivos `.ini` na pasta `configuracoes/`.

### **Arquivo: `configsemdvp.ini`** (sem desvio padrão)

```ini
TAM_POPULACAO = 300          # Tamanho da população
TAXA_MUTACAO = 0.20          # Taxa de mutação (20%)
TAXA_CRUZAMENTO = 0.95       # Taxa de cruzamento (95%)
TAXA_ELITISMO = 0.5          # Taxa de elitismo (50%)
MAX_GERACOES = 500           # Máximo de gerações
MAX_MOVIMENTOS = 60          # Máximo de movimentos por indivíduo
ARQUIVO_LABIRINTO = Mapas/maze.txt
PESO_DISTANCIA = 100         # Penalidade por distância
PESO_OBSTACULO = 100         # Penalidade por colisão
PESO_DESVIO = 0              # Penalidade por desvio padrão
TAM_TORNEIO = 5              # Tamanho do torneio
ARQUIVO_LOG = log_semdvp.csv
```

### **Arquivo: `configcomdvp.ini`** (com desvio padrão)

```ini
TAM_POPULACAO = 300
TAXA_MUTACAO = 0.20
TAXA_CRUZAMENTO = 0.95
TAXA_ELITISMO = 0.5
MAX_GERACOES = 500
MAX_MOVIMENTOS = 60
ARQUIVO_LABIRINTO = Mapas/maze2.txt
PESO_DISTANCIA = 100
PESO_OBSTACULO = 100
PESO_DESVIO = 1              # Ativa penalidade de desvio padrão
TAM_TORNEIO = 5
ARQUIVO_LOG = log_comdvp.csv
```

### **Parâmetros Explicados**

| Parâmetro | Descrição |
|-----------|-----------|
| `TAM_POPULACAO` | Número de indivíduos em cada geração |
| `TAXA_MUTACAO` | Probabilidade de mutação (0.0 a 1.0) |
| `TAXA_CRUZAMENTO` | Probabilidade de cruzamento (0.0 a 1.0) |
| `TAXA_ELITISMO` | Fração da população preservada (0.0 a 1.0) |
| `MAX_GERACOES` | Limite de gerações |
| `MAX_MOVIMENTOS` | Comprimento máximo de sequência de movimentos |
| `PESO_DISTANCIA` | Peso na penalidade de distância até saída |
| `PESO_OBSTACULO` | Peso na penalidade por colisões |
| `PESO_DESVIO` | Peso na penalidade de desvio padrão |

---

## 📁 Estrutura do Projeto

```
Labirinto_genetico/
├── main.c                    # Função principal
├── config.c / config.h       # Gerenciamento de configuração
├── genetic.c / genetic.h     # Algoritmo genético
├── individual.c / individual.h # Avaliação de indivíduos
├── maze.c / maze.h           # Manipulação do labirinto
├── Makefile                  # Script de compilação
├── Readme.md                 # Este arquivo
├── configuracoes/
│   ├── configsemdvp.ini      # Configuração sem DVP
│   └── configcomdvp.ini      # Configuração com DVP
├── Mapas/
│   ├── maze.txt              # Labirinto 1
│   └── maze2.txt             # Labirinto 2
└── Logs/
    ├── log_semdvp.csv        # Histórico de execução (sem DVP)
    └── log_comdvp.csv        # Histórico de execução (com DVP)
```

---

## 🗺️ Formato do Labirinto

Os labirintos são definidos em arquivos de texto simples:

```
##########
#S    #  #
# #####  #
# #     ##
# # ###  #
#   # # E#
##########
```

### **Caracteres Válidos**

| Caractere | Significado |
|-----------|------------|
| `#` | Parede (obstáculo) |
| `S` | Ponto de partida (Start) |
| `E` | Ponto de saída (End) |
| ` ` | Espaço livre (caminho válido) |

---

## 🧬 Parâmetros Genéticos

### **Função de Aptidão**

```
aptidao = (1000 - peso_distancia * distancia - peso_obstaculo * colisoes) 
          × (1 + peso_desvio * desvio_padrão)
```

Onde:
- **distancia**: Distância Manhattan até a saída
- **colisoes**: Penalidade por movimentos inválidos
- **desvio_padrão**: Variação nos movimentos

### **Seleção por Torneio**

- Seleciona aleatoriamente `TAM_TORNEIO` indivíduos
- Escolhe o melhor deles como pai

### **Cruzamento (2-point)**

- Divide os movimentos em 2 pontos
- Combina seções dos dois pais

### **Mutação**

- Com probabilidade `TAXA_MUTACAO`, altera movimentos aleatoriamente
- Evita movimentos redundantes (C-B, E-D, etc.)

---

## 📊 Saída Esperada

### **Durante a Execução:**

```
Arquivo de configuracao: configuracoes/configsemdvp.ini
Arquivo do labirinto : Mapas/maze.txt
##########
#S    #  #
# #####  #
...
Geracao    0 - Melhor Aptidao:     34 | Dist: 13 | Colisoes:   0 | Passos:  8 | Desvio: 0.00
Geracao   50 - Melhor Aptidao:    312 | Dist:  7 | Colisoes:   0 | Passos: 25 | Desvio: 0.00
Geracao  100 - Melhor Aptidao:    650 | Dist:  2 | Colisoes:   0 | Passos: 28 | Desvio: 0.00

SOLUCAO ENCONTRADA na geracao 145!
Caminho para a saida:
```

### **Arquivo de Log (`Logs/log_semdvp.csv`):**

```csv
geracao;aptidao;movimentos
1;34;CCCBBBBBEEEEEEEEEEEEEE
2;45;CCCBBBBEEEEEEEEEEE
...
```

---

## 💡 Exemplos

### **Exemplo 1: Compilar e Executar com Make**

```bash
cd Labirinto_genetico
make run
```

### **Exemplo 2: Compilar Manualmente e Rodar**

```bash
gcc -Wall -Wextra -std=c99 -lm -O2 -o solver main.c config.c genetic.c individual.c maze.c
./solver configsemdvp.ini Mapas/maze.txt
```

### **Exemplo 3: Limpar e Recompilar**

```bash
make clean-all
make
make run-dvp
```

---

## 🔍 Estrutura do Código

### **main.c**
- Inicializa o sistema
- Loop principal de gerações
- Gerenciamento de logs

### **genetic.c**
- Operadores genéticos (cruzamento, mutação)
- Seleção e evolução da população
- Nova geração de indivíduos

### **individual.c**
- Cálculo de aptidão
- Validação de movimentos
- Visualização de caminhos

### **maze.c**
- Carregamento do labirinto
- Detecção de posições (início/saída)
- Manipulação da estrutura do mapa

### **config.c**
- Parser de arquivos `.ini`
- Carregamento de configurações

---

## 🐛 Troubleshooting

### **Erro: "No such file or directory"**
- Verifique se os diretórios `configuracoes/`, `Mapas/` e `Logs/` existem
- Crie-os manualmente se necessário

### **Erro: "gcc: command not found"**
- Instale um compilador C (GCC, Clang, etc.)
- Windows: Use MinGW ou MSYS2

### **Compilação com Warnings**
- Use `-Wall -Wextra` para detectar problemas
- O código foi otimizado para compilar sem warnings

### **Programa não encontra o labirinto**
- Verifique o caminho em `ARQUIVO_LABIRINTO` no arquivo `.ini`
- Use caminhos relativos a partir do diretório raiz do projeto

---

## 📈 Análise de Resultados

Os arquivos de log (`.csv`) podem ser analisados com:

```bash
# Linux/macOS
cat Logs/log_semdvp.csv | head -20

# Windows
type Logs\log_semdvp.csv | more
```

Para gráficos, use Python:

```python
import pandas as pd
import matplotlib.pyplot as plt

df = pd.read_csv('Logs/log_semdvp.csv', sep=';')
plt.plot(df['geracao'], df['aptidao'])
plt.xlabel('Geração')
plt.ylabel('Aptidão')
plt.title('Evolução do Melhor Indivíduo')
plt.show()
```

---

## 🎓 Conceitos Aprendidos

- ✅ Algoritmos Genéticos
- ✅ Otimização Heurística
- ✅ Programação em C
- ✅ Manipulação de Estruturas de Dados
- ✅ Parser de Configuração
- ✅ Busca em Espaços

---

## 📝 Licença

Este projeto é fornecido como está para fins educacionais.

---

## 👥 Autores

- **Kayran Silva** - Desenvolvimento e algoritmo genético
- **Thales Rafael** - Estrutura do projeto e testes

---

## 📞 Suporte

Se encontrar problemas:
1. Verifique se todos os arquivos estão presentes
2. Confirme que os diretórios têm as permissões corretas
3. Teste com um labirinto simples primeiro
4. Verifique os parâmetros de configuração

---

**⭐ Se gostou, dê uma estrela no GitHub!**
