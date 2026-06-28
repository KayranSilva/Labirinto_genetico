# Documentação Técnica - Labirinto Genético

## 🔬 Visão Geral Técnica

Este documento descreve os detalhes técnicos da implementação do algoritmo genético para resolução de labirintos.

---

## 📊 Estrutura de Dados

### `Individuo`
```c
typedef struct {
    char *movimentos;        // Sequência de movimentos
    int aptidao;            // Valor de fitness
    float pontuacao_movimentos; // Pontuação dos movimentos
    float desvio_padrao;    // Desvio padrão (para variância)
    int distancia;          // Distância até a saída
    int colisoes;           // Número de colisões
    int passos_validos;     // Passos realizados com sucesso
} Individuo;
```

### `NoPopulacao`
```c
typedef struct NoPopulacao {
    Individuo individuo;
    struct NoPopulacao *proximo;
} NoPopulacao;
```

Usa lista encadeada para armazenar a população.

### `Configuracoes`
Armazena todos os parâmetros do algoritmo genético carregados do arquivo `.ini`.

---

## 🧬 Algoritmo Genético Detalhado

### 1. **Inicialização da População**

- Cria `TAM_POPULACAO` indivíduos
- Cada indivíduo tem `MAX_MOVIMENTOS` movimentos aleatórios
- Evita gerar dois movimentos opostos consecutivos (C-B, E-D, etc.)

### 2. **Seleção por Torneio**

```
Algoritmo:
1. Seleciona TAM_TORNEIO indivíduos aleatoriamente
2. Retorna o indivíduo com maior aptidão
```

**Probabilidade**: Indivíduos melhores têm maior chance de seleção.

### 3. **Cruzamento (Crossover 2-Pontos)**

```
Algoritmo:
1. Sorteia dois pontos de corte (ponto1, ponto2)
2. Filho1 = [Pai1[0..p1], Pai2[p1..p2], Pai1[p2..fim]]
3. Filho2 = [Pai2[0..p1], Pai1[p1..p2], Pai2[p2..fim]]
```

**Taxa**: `TAXA_CRUZAMENTO` (padrão: 95%)

### 4. **Mutação**

```
Algoritmo:
Para cada gene:
  Se random < TAXA_MUTACAO:
    Substitui por movimento aleatório
    Evita movimentos redundantes
```

**Taxa**: `TAXA_MUTACAO` (padrão: 20%)

### 5. **Cálculo de Aptidão**

```
aptidao = (5000 - PESO_DISTANCIA × distancia 
                - PESO_OBSTACULO × colisoes) 
        × (1 + PESO_DESVIO × desvio_padrão)

Onde:
- distancia = Distância Manhattan até saída
- colisoes = Número de movimentos inválidos
- desvio_padrão = Variância na sequência de movimentos
```

**Valores Padrão**:
- PESO_DISTANCIA = 100
- PESO_OBSTACULO = 100  
- PESO_DESVIO = 0 (ou 1 com DVP)

### 6. **Elitismo**

Preserva os `TAXA_ELITISMO × TAM_POPULACAO` melhores indivíduos para a próxima geração.

---

## 🗂️ Arquitetura dos Arquivos

### `main.c`
- Loop principal de gerações
- Gerenciamento de I/O
- Logging de resultados

### `genetic.c`
- Operadores genéticos
- Evolução da população
- Seleção e reprodução

### `individual.c`
- Cálculo de aptidão
- Validação de caminho
- Visualização de soluções

### `maze.c`
- Carregamento de arquivo
- Manipulação da estrutura do mapa
- Detecção de posições

### `config.c`
- Parser de arquivo `.ini`
- Trim de strings
- Carregamento de configurações

---

## 📈 Métricas de Desempenho

### Convergência
- **Objetivo**: Reduzir distância para 0
- **Secundário**: Minimizar colisões

### Log de Execução
```csv
geracao;aptidao;movimentos
1;4200.0;DDDDCEBEBECCCDCDCDBDCCDDBECCDCECCCDBECDDDDDBBDBEBDDCBDDCCEBD
2;4300.0;BBBBDCDDDDBBEBBEEEBBEEBEBDDCCEBDBEDBEEECCDDDBDDBEBECDBDBDDEC
```

---

## 🐛 Ajustes e Otimizações

### Penalidades de Colisão
- **Movimentos Redundantes**: +1 à colisão
- **Saída de Limites**: +1 à colisão
- **Colisão com Parede**: +1 à colisão

### Parâmetros Recomendados

**Para Labirintos Pequenos (< 10×10)**:
```ini
TAM_POPULACAO = 100
MAX_GERACOES = 100
MAX_MOVIMENTOS = 30
```

**Para Labirintos Médios (10×10 - 50×50)**:
```ini
TAM_POPULACAO = 300
MAX_GERACOES = 500
MAX_MOVIMENTOS = 60
```

**Para Labirintos Grandes (> 50×50)**:
```ini
TAM_POPULACAO = 500
MAX_GERACOES = 1000
MAX_MOVIMENTOS = 100
```

---

## 🔄 Fluxo de Execução

```
1. Carregar Configuração (.ini)
   ↓
2. Carregar Labirinto (arquivo.txt)
   ↓
3. Encontrar Posições S e E
   ↓
4. Inicializar População
   ↓
5. LOOP Gerações:
   a) Avaliar Aptidão
   b) Criar Nova Geração
   c) Verificar Solução
   ↓
6. Salvar Log
   ↓
7. Exibir Melhor Resultado
```

---

## 🧪 Teste Unitário Manual

### Teste 1: Labirinto 7×10
```bash
./labirinto_genetico configsemdvp.ini Mapas/maze.txt
# Resultado esperado: Solução em < 50 gerações
```

### Teste 2: Com Desvio Padrão
```bash
./labirinto_genetico configcomdvp.ini Mapas/maze2.txt
# Resultado esperado: Solução em < 100 gerações
```

---

## 💾 Formato do Arquivo de Configuração

```ini
# Comentários com # ou ;
TAM_POPULACAO = 300         # [50-1000]
TAXA_MUTACAO = 0.20         # [0.01-1.0]
TAXA_CRUZAMENTO = 0.95      # [0.0-1.0]
TAXA_ELITISMO = 0.5         # [0.0-1.0]
MAX_GERACOES = 500          # [10-10000]
MAX_MOVIMENTOS = 60         # [10-200]
ARQUIVO_LABIRINTO = Mapas/maze.txt
ARQUIVO_LOG = log_semdvp.csv
PESO_DISTANCIA = 100
PESO_OBSTACULO = 100
PESO_DESVIO = 0             # [0-10]
TAM_TORNEIO = 5             # [2-50]
```

---

## ⚙️ Otimizações de Compilação

```bash
# Compilação com otimização
gcc -Wall -Wextra -std=c99 -lm -O2 -o labirinto_genetico *.c

# Compilação com debug
gcc -Wall -Wextra -std=c99 -lm -g -o labirinto_genetico *.c

# Compilação com profile
gcc -Wall -Wextra -std=c99 -lm -pg -o labirinto_genetico *.c
gprof labirinto_genetico gmon.out
```

---

## 📊 Análise de Resultados em Python

```python
import pandas as pd
import matplotlib.pyplot as plt

# Carregar dados
df = pd.read_csv('Logs/log_semdvp.csv', sep=';')

# Plotar evolução
plt.figure(figsize=(12, 6))
plt.plot(df['geracao'], df['aptidao'], marker='o')
plt.xlabel('Geração')
plt.ylabel('Aptidão')
plt.title('Evolução do Melhor Indivíduo')
plt.grid(True, alpha=0.3)
plt.savefig('evolucao.png')
plt.show()

# Estatísticas
print(f"Gerações: {len(df)}")
print(f"Aptidão Inicial: {df['aptidao'].iloc[0]}")
print(f"Aptidão Final: {df['aptidao'].iloc[-1]}")
print(f"Melhoria: {((df['aptidao'].iloc[-1] - df['aptidao'].iloc[0]) / df['aptidao'].iloc[0] * 100):.2f}%")
```



**Última atualização**: 27/06/2026  
**Versão**: 1.0
