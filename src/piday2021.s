  .org $8000

  .include lib/vga.s
  .include lib/random.s
  .include lib/lcd.s
  .include lib/via.s


squareroots:
  .binary data/squareroots.dat


ZP_RANDOMCOLOURS_FLAG = $38

reset:
  ldx #$ff
  txs

  jsr via_init

  jsr printimm
  .asciiz "Hello, World!"

  jsr vram_init

  lda #%0000
  jsr vram_clear

	jsr wait_button

	lda #0
	sta ZP_RANDOMCOLOURS_FLAG

	lda #0
	sta ZP_BGCOLOR

	lda #1
	sta ZP_FGCOLOR

	ldx #0
	stx DRAWSTRING_X
	ldy #2
	sty DRAWSTRING_Y
	jsr drawstringimm
	.asciiz "to /r/beneater"

	jsr wait_button

	lda #4
	sta ZP_FGCOLOR

	ldx #130
	stx DRAWSTRING_X
	ldy #175
	sty DRAWSTRING_Y
	jsr drawstringimm
	.asciiz "from"

	ldx #116
	stx DRAWSTRING_X
	ldy #185
	sty DRAWSTRING_Y
	jsr drawstringimm
	.asciiz "/u/gfoot360"

	jsr wait_button


	lda #1
	sta ZP_FGCOLOR
	lda #0
	sta ZP_BGCOLOR
	lda #96
	ldx #$20
	ldy #$20
	jsr draw_circle

	jsr wait_button

	lda ZP_FGCOLOR
	sta ZP_BGCOLOR
	lda #0
	sta ZP_FGCOLOR
	lda #80
	ldx #$27
	ldy #$1b
	jsr draw_circle

	jsr wait_button

	lda ZP_FGCOLOR
	sta ZP_BGCOLOR
	lda #4
	sta ZP_FGCOLOR
	lda #64
	ldx #$31
	ldy #$16
	jsr draw_circle

	jsr wait_button

	lda ZP_FGCOLOR
	sta ZP_BGCOLOR
	lda #5
	sta ZP_FGCOLOR
	lda #48
	ldx #$41
	ldy #$10
	jsr draw_circle

	jsr wait_button

	lda ZP_FGCOLOR
	sta ZP_BGCOLOR
	lda #1
	sta ZP_FGCOLOR
	lda #32
	ldx #$61
	ldy #$0b
	jsr draw_circle

	jsr wait_button

	lda ZP_FGCOLOR
	sta ZP_BGCOLOR
	lda #0
	sta ZP_FGCOLOR
	lda #16
	ldx #$c1
	ldy #$05
	jsr draw_circle

	jsr wait_button
	jsr wait_button

	lda #5
	sta ZP_BGCOLOR
	lda #1
	sta ZP_FGCOLOR
	lda #32
	ldx #$61
	ldy #$0b
	jsr draw_circle

	lda ZP_FGCOLOR
	sta ZP_BGCOLOR
	lda #5
	sta ZP_FGCOLOR

	ldx #70
	stx DRAWSTRING_X
	ldy #86
	sty DRAWSTRING_Y
	jsr drawstringimm
	.asciiz "HAPPY"

	ldx #68
	stx DRAWSTRING_X
	ldy #96
	sty DRAWSTRING_Y
	jsr drawstringimm
	.asciiz "PI DAY"

	ldx #72
	stx DRAWSTRING_X
	ldy #106
	sty DRAWSTRING_Y
	jsr drawstringimm
	.asciiz "2021"

	jsr wait_button

	lda #1
	sta ZP_RANDOMCOLOURS_FLAG

.loop:
	ldx #70
	stx DRAWSTRING_X
	ldy #86
	sty DRAWSTRING_Y
	jsr drawstringimm
	.asciiz "HAPPY"

	ldx #68
	stx DRAWSTRING_X
	ldy #96
	sty DRAWSTRING_Y
	jsr drawstringimm
	.asciiz "PI DAY"

	ldx #72
	stx DRAWSTRING_X
	ldy #106
	sty DRAWSTRING_Y
	jsr drawstringimm
	.asciiz "2021"

	jmp .loop


mulf:
.ARG1 = $30
.ARG2 = $31
.RESULT = $0
	; Multiply A by X, shift right 4, truncate
	sta .ARG1
	stx .ARG2
	lda #0
	sta .RESULT
	sta .RESULT+1
	ldx #8
.loop
	asl .ARG1
	bcc .nocarry
	clc
	lda .RESULT
	adc .ARG2
	sta .RESULT
	lda .RESULT+1
	adc #0
	sta .RESULT+1

.nocarry
	asl .RESULT
	rol .RESULT+1
	dex
	bne .loop

	lda .RESULT+1
	asl .RESULT
	rol
	asl .RESULT
	rol

	rts


draw_circle:
.CENTREX = 80
.CENTREY = 100

.YPOS = $10
.WIDTH = $11
.LEFT = $12
.RIGHT = $13
.HALFWIDTH = $14
.MUL1 = $15
.MUL2 = $16

	sta .YPOS
	stx .MUL1
	sty .MUL2

.yloop:
	ldx .YPOS
	bne .notdoneyet
	rts

.notdoneyet
	dex
	stx .YPOS

	lda .MUL1
	jsr mulf
	tax
	lda squareroots,x   ; sqrt(96*96 - YPOS*YPOS)

	ldx .MUL2
	jsr mulf

	sta .WIDTH
	lsr
	sta .HALFWIDTH

	sec
	lda #.CENTREX
	sbc .HALFWIDTH
	sta .LEFT

	lda .YPOS
	clc
	adc #.CENTREY
	jsr vram_openline
	jsr .doline

	sec
	lda #.CENTREY
	sbc .YPOS
	jsr vram_openline
	jsr .doline

	jmp .yloop


.doline

	lda .WIDTH
	and #1
	beq .nooddpixels

	ldy .LEFT
	dey
	lda ZP_BGCOLOR
	asl
	ora ZP_FGCOLOR
	ora #BITS_DEFAULT
	sta (ZP_PTR),y

	clc
	lda #.CENTREX
	adc .HALFWIDTH
	tay
	lda ZP_FGCOLOR
	asl
	ora ZP_BGCOLOR
	ora #BITS_DEFAULT
	sta (ZP_PTR),y

.nooddpixels
	lda ZP_FGCOLOR
	asl
	ora ZP_FGCOLOR
	ora #BITS_DEFAULT

	ldy .LEFT
	ldx .HALFWIDTH
.wloop:
	sta (ZP_PTR),y
	iny
	sta (ZP_PTR),y
	iny
	dex
	bne .wloop

	rts



wait_button:
  lda PORTA
  and #1
  beq .buttonpressed
  jmp wait_button

.buttonpressed:
  ldx #0
.loop:
  dex
  beq .done
  lda PORTA
  and #1
  bne .loop
  ldx #0
  jmp .loop
.done
  rts


drawstringimm:
  pha
  txa
  pha

  tsx
  clc
  lda $103,x
  adc #1
  sta printmessage_bufferptr
  lda $104,x
  adc #0
  sta printmessage_bufferptr+1

  jsr drawstring

  lda printmessage_bufferptr
  sta $103,x
  lda printmessage_bufferptr+1
  sta $104,x

  pla
  tax
  pla
  rts


DRAWSTRING_X = $30
DRAWSTRING_Y = $31

drawstring:
.TEMP_LOOPCOUNT = $32

  pha
	txa
	pha
	tya
	pha

  ldy #0
.loop:
  lda (printmessage_bufferptr),y
  beq .endloop

	sty .TEMP_LOOPCOUNT

	ldx DRAWSTRING_X
	ldy DRAWSTRING_Y
	jsr vid_drawchar

	ldx DRAWSTRING_X
	inx
	inx
	inx
	inx
	stx DRAWSTRING_X

	ldy ZP_RANDOMCOLOURS_FLAG
	beq .notrandomcolours

	jsr nextcolour

.notrandomcolours

	ldy .TEMP_LOOPCOUNT
  iny
  jmp .loop

.endloop:
  clc
  tya
  adc printmessage_bufferptr
  sta printmessage_bufferptr
  lda printmessage_bufferptr+1
  adc #0
  sta printmessage_bufferptr+1

	pla
	tay
  pla
  tax
  pla
  rts


nextcolour:
	jsr random
	and #5
	cmp #1
	beq nextcolour
	sta ZP_FGCOLOR
  jmp waitvsync

waitvsync
  lda PORTA
  and #$10
  bne waitvsync
.loop
  lda PORTA
  and #$10
  beq .loop
  rts


  .org $fffc
  .word reset
  .word $0000
