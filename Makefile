BINFILES = bin/snake.out bin/vgatest.out bin/piday2021.out bin/vgademo.out bin/vgatest_640x480x3bpp.out bin/spritetest.out

all: $(BINFILES)

clean:
	rm -f $(BINFILES)

bin/%.out: src/%.s src/*.s src/lib/*.s
	vasm.vasm6502-oldstyle -Fbin -dotdir $< -o $@

