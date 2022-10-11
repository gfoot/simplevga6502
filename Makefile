#BINFILES += bin/snake.out
BINFILES += bin/vgatest.out
BINFILES += bin/piday2021.out
BINFILES += bin/vgademo.out
BINFILES += bin/vgatest_640x480x3bpp.out
BINFILES += bin/spritetest.out
BINFILES += bin/vgatest_text.out

all: $(BINFILES)

clean:
	rm -f $(BINFILES)

bin/%.out: src/%.s src/*.s src/lib/*.s
	vasm.vasm6502-oldstyle -Fbin -dotdir $< -o $@

burn/%.out: bin/%.out
	@(diff -q $< burn/burned.out 2>/dev/null && echo "Identical to last burn") || (minipro -p AT28C256E -w $< && cp -f $< burn/burned.out)

