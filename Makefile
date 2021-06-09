BINFILES = bin/snake.out bin/vgatest.out bin/piday2021.out bin/vgademo.out
VASM ?= vasm.vasm6502-oldstyle

all: $(BINFILES)

clean:
	rm -f $(BINFILES)

bin/%.out: src/%.s src/*.s src/lib/*.s
	$(VASM) -Fbin -dotdir $< -o $@

