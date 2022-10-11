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
  jsr draw_circle

  jsr wait_button

  lda ZP_FGCOLOR
  sta ZP_BGCOLOR
  lda #0
  sta ZP_FGCOLOR
  lda #80
  jsr draw_circle

  jsr wait_button

  lda ZP_FGCOLOR
  sta ZP_BGCOLOR
  lda #4
  sta ZP_FGCOLOR
  lda #64
  jsr draw_circle

  jsr wait_button

  lda ZP_FGCOLOR
  sta ZP_BGCOLOR
  lda #5
  sta ZP_FGCOLOR
  lda #48
  jsr draw_circle

  jsr wait_button

  lda ZP_FGCOLOR
  sta ZP_BGCOLOR
  lda #1
  sta ZP_FGCOLOR
  lda #32
  jsr draw_circle

  jsr wait_button

  lda ZP_FGCOLOR
  sta ZP_BGCOLOR
  lda #0
  sta ZP_FGCOLOR
  lda #16
  jsr draw_circle

  jsr wait_button
  jsr wait_button

  lda #5
  sta ZP_BGCOLOR
  lda #1
  sta ZP_FGCOLOR
  lda #32
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


draw_circle:
  ; Radius in A
  ;
  ; New version using Midpoint Algorithm
  ; Thanks to Gordon Henderson for the pointer!
.Y1 = $90   ; Y counting up
.Y2 = $91   ; Y counting down
.X1 = $92   ; X at Y
.X2 = $93   ; X at YY
.RES = $94  ; two bytes

  sta .X1
  sta .RES
  sec
  sbc #1
  sta .Y2
  lda #0
  sta .Y1
  sta .X2
  sta .RES+1

.loop
  ; hline Y1 -X1 X1
  ; hline -Y1 -X1 X1
  lda .Y1
  ldx .X1
  jsr .dolines

  ; x2 += 1
  inc .X2

  ; residue -= y1
  sec
  lda .RES
  sbc .Y1
  sta .RES
  lda .RES+1
  sbc #0
  sta .RES+1

  ; y1 += 1
  inc .Y1

  ; residue -= y1
  sec
  lda .RES
  sbc .Y1
  sta .RES
  lda .RES+1
  sbc #0
  sta .RES+1

  ; if residue < 0:
  bpl .notneg

  ; residue += x1
  clc
  lda .RES
  adc .X1
  sta .RES
  lda .RES+1
  adc #0
  sta .RES+1

  ; x1 -= 1
  dec .X1

  ; residue += x1
  clc
  lda .RES
  adc .X1
  sta .RES
  lda .RES+1
  adc #0
  sta .RES+1

  ; hline Y2 -X2 X2
  ; hline -Y2 -X2 X2
  lda .Y2
  ldx .X2
  jsr .dolines

  dec .Y2

.notneg
  jsr waitvsync
  lda .Y2
  cmp .Y1
  bpl .loop

  rts

.dolines
.TEMP_Y = $a0
  ; A = Y coord
  ; X = X coord
  ;
  ; Draw two horizontal lines - one at +Y,
  ; one at -Y - from -X to +X

  sta .TEMP_Y

  txa
  lsr
  sta .HLINE_HW

  eor #$ff
  sec ;+1
  adc #80
  sta .HLINE_X

  txa
  and #1
  sta .HLINE_ODD

  sec ;+1
  lda #100
  adc .TEMP_Y
  jsr .hline

  sec
  lda #100
  sbc .TEMP_Y

.hline
.HLINE_ODD = $a1
.HLINE_X = $a2
.HLINE_HW = $a3
  jsr vram_openline

  lda .HLINE_ODD
  beq .nooddpixels

  ldy .HLINE_X
  dey
  lda ZP_BGCOLOR
  asl
  ora ZP_FGCOLOR
  ora #BITS_DEFAULT
  sta (ZP_PTR),y

  lda .HLINE_HW
  asl
  clc
  adc .HLINE_X
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

  ldy .HLINE_X
  ldx .HLINE_HW
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
  jsr vid_printchar

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
