BINFILES = bin/snake.out bin/vgatest.out

all: $(BINFILES)

clean:
	rm -f $(BINFILES)

bin/%.out: src/%.s src/*.s src/lib/*.s
	vasm.vasm6502-oldstyle -Fbin -dotdir $< -o $@

