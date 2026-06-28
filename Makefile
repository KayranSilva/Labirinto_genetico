CC = gcc
CFLAGS = -Wall -Wextra -std=c99 -lm -O2
TARGET = labirinto_genetico
SRCDIR = .
OBJDIR = obj
BINDIR = bin

# Arquivos fonte
SOURCES = main.c config.c genetic.c individual.c maze.c
OBJECTS = $(addprefix $(OBJDIR)/,$(SOURCES:.c=.o))

# Alvo padrão
all: $(BINDIR)/$(TARGET)

# Criação do diretório de objetos
$(OBJDIR):
	@mkdir -p $(OBJDIR)

# Criação do diretório de binários
$(BINDIR):
	@mkdir -p $(BINDIR)

# Compilação de arquivos objeto
$(OBJDIR)/%.o: $(SRCDIR)/%.c | $(OBJDIR)
	$(CC) -c $< -o $@ $(CFLAGS)

# Linkagem do executável
$(BINDIR)/$(TARGET): $(OBJECTS) | $(BINDIR)
	$(CC) $(OBJECTS) -o $@ $(CFLAGS)
	@echo "✓ Compilação concluída com sucesso!"
	@echo "✓ Executável: $(BINDIR)/$(TARGET)"

# Executar o programa
run: all
	@echo "Executando com configuração padrão (sem DVP)..."
	./$(BINDIR)/$(TARGET) configsemdvp.ini Mapas/maze.txt

# Executar com DVP
run-dvp: all
	@echo "Executando com configuração DVP..."
	./$(BINDIR)/$(TARGET) configcomdvp.ini Mapas/maze2.txt

# Limpar arquivos temporários
clean:
	@rm -rf $(OBJDIR)
	@echo "✓ Arquivos objeto removidos"

# Limpar tudo (objetos + binário)
clean-all: clean
	@rm -rf $(BINDIR)
	@echo "✓ Binário removido"

# Help
help:
	@echo "Comandos disponíveis:"
	@echo "  make          - Compila o projeto"
	@echo "  make run      - Compila e executa (sem DVP)"
	@echo "  make run-dvp  - Compila e executa (com DVP)"
	@echo "  make clean    - Remove objetos"
	@echo "  make clean-all - Remove tudo"
	@echo "  make help     - Mostra esta mensagem"

.PHONY: all run run-dvp clean clean-all help
