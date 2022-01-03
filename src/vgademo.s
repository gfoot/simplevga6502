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
  jsr lcd_init

  jsr printimm
  .asciiz "Hello, World!"

  jsr vram_init

  lda #%0000
  jsr vram_clear

  jsr wait_button

  lda #160
  sta regionfill.W
  lda #240
  sta regionfill.H

  lda #0
  sta regionfill.X
  lda #0
  sta regionfill.Y
  sta regionfill.Y+1
  lda #BITS_DEFAULT | %1010
  sta regionfill.VALUES
  lda #BITS_DEFAULT | %0000
  sta regionfill.VALUES+1
  lda #BITS_DEFAULT | %0101
  sta regionfill.VALUES+2
  lda #BITS_DEFAULT | %0000
  sta regionfill.VALUES+3
  jsr regionfill

  lda #240
  sta regionfill.Y
  jsr regionfill
  
  lda #0
  sta ZP_RANDOMCOLOURS_FLAG

  lda #0
  sta ZP_BGCOLOR

  lda #5
  sta ZP_FGCOLOR

  ldx #2
  stx DRAWSTRING_X
  ldy #8
  sty DRAWSTRING_Y
  ldy #0
  sty DRAWSTRING_Y+1
  jsr drawstringimm
  .asciiz "320x480"

  ldx #12
  stx DRAWSTRING_X
  ldy #16
  sty DRAWSTRING_Y
  ldy #0
  sty DRAWSTRING_Y+1
  jsr drawstringimm
  .asciiz "on"

  ldx #2
  stx DRAWSTRING_X
  ldy #24
  sty DRAWSTRING_Y
  ldy #0
  sty DRAWSTRING_Y+1
  jsr drawstringimm
  .asciiz "640x480"

  lda #0
  sta ZP_FGCOLOR
  lda #0
  sta ZP_BGCOLOR
  lda #220
  jsr draw_circle

  lda #1
  sta ZP_BGCOLOR
  lda #210
  sta $9c

.circleloop
  ldx ZP_FGCOLOR
  lda ZP_BGCOLOR
  eor #5
  sta ZP_FGCOLOR
  stx ZP_BGCOLOR

  lda $9c
  jsr draw_circle

  sec
  lda $9c
  sbc #8
  sta $9c
  cmp #6
  bcs .circleloop

.loop1
  lda #65
  sta $0

.loop2
  jsr wait_button

  jsr lcd_clear

  lda $0
  jsr print_char

  inc $0
  lda $0
  cmp #91
  beq .loop1
  jmp .loop2

.stop
  jmp .stop


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
  ;jsr waitvsync
  lda .Y2
  cmp .Y1
  bcs .loop

  rts

.dolines
.TEMP_Y = $a0
  ; A = Y coord
  ; X = X coord
  ;
  ; Draw two horizontal lines - one at +Y,
  ; one at -Y - from -X to +X
  ;
  ; Due to aspect ratio, also divide X by two

  sta .TEMP_Y

  txa
  lsr
  lsr
  sta .HLINE_HW

  eor #$ff
  sec ;+1
  adc #80
  sta .HLINE_X

  txa
  lsr
  and #1
  sta .HLINE_ODD

  sec ;+1
  lda #240
  adc .TEMP_Y
  tax
  lda #0
  adc #0
  tay
  txa
  jsr .hline

  sec
  lda #240
  sbc .TEMP_Y
  tax
  lda #0
  sbc #0
  tay
  txa

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
.TEMP_LOOPCOUNT = $33

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
  stx ZP_DRAWCHAR_X
  ldy DRAWSTRING_Y
  sty ZP_DRAWCHAR_Y
  ldy DRAWSTRING_Y+1
  sty ZP_DRAWCHAR_Y+1
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



regionfill:
.X = $90      ; in bytes
.Y = $91
.W = $93      ; in bytes
.H = $94
.VALUES = $95 ; 4 bytes

  ldx .H
  dex
.yloop

  txa
  clc
  adc .Y
  pha
  lda #0
  adc .Y+1
  tay
  pla
  jsr vram_openline

  lda .X
  sta ZP_PTR
  
  txa
  and #3
  tay
  lda .VALUES,y

  ldy .W
.xloop
  dey
  sta (ZP_PTR),y
  bne .xloop

  dex
  cpx #$ff
  bne .yloop

  rts


linefill:
  ; A = fill value
  ; Y = width in bytes
  dey
  sta (ZP_PTR),y
  bne linefill
  rts


  .org $fffc
  .word reset
  .word $0000
