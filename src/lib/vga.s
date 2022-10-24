
BIT_RESET = %10000000
BIT_VSYNC = %01000000
BIT_HSYNC = %00100000
BIT_HRESET = %00010000
BITS_PIXELDATA = %00001111

BITS_DEFAULT = BIT_HRESET | BIT_RESET

VGA_H_VISIBLE = 800  ;  640
VGA_H_FPORCH =   24  ;   16
VGA_H_SYNC =     72  ;   96
VGA_H_BPORCH =  128  ;   48
VGA_H_STRIDE = 1024
VGA_H_DIVISOR =   4

VGA_V_VISIBLE = 600  ; 400  480
VGA_V_FPORCH =    1  ;  12   10
VGA_V_SYNC =      2  ;   2    2
VGA_V_BPORCH =   22  ;  35   33
VGA_V_DIVISOR =   1

VRAM_BASE = $8000
VRAM_STRIDE = VGA_H_STRIDE / VGA_H_DIVISOR
VRAM_WIDTH = VGA_H_VISIBLE / VGA_H_DIVISOR
VRAM_HEIGHT = VGA_V_VISIBLE / VGA_V_DIVISOR
VRAM_MAX = VRAM_BASE + VRAM_STRIDE * (VRAM_HEIGHT-1) + VRAM_WIDTH


ZP_PTR = $0
ZP_VISIBLE = $2
ZP_PORCH = $3
ZP_TEMP = $4
ZP_BANK = $5
ZP_FGCOLOR = $6
ZP_BGCOLOR = $7

ZP_TEXTPOS_X = $2
ZP_TEXTPOS_Y = $3 ; two bytes
ZP_PRINTCHAR_DY = $5
ZP_PRINTCHAR_BITS = $8 ; two bytes
ZP_PRINTCHAR_SRC = $a ; two bytes
ZP_PRINTSTRING_LOOPCOUNT = $c


; Store A in Y locations starting from ($0) and advance ($0)
vram_fill_block:
  sty ZP_TEMP
.loop:
  dey
  sta (ZP_PTR),y
  bne .loop
  clc
  lda ZP_PTR
  adc ZP_TEMP
  sta ZP_PTR
  lda ZP_PTR+1
  adc #0
  sta ZP_PTR+1
  rts


; Fill X lines starting from ($0) using the configured byte values
vram_fill_lines:

  ; Padding - no-op on first line, important on others
  lda ZP_PTR
  and #(VGA_H_STRIDE/VGA_H_DIVISOR)-1
  beq .aligned
  eor ZP_PTR
  clc
  adc #<VGA_H_STRIDE/VGA_H_DIVISOR
  sta ZP_PTR
  lda ZP_PTR+1
  adc #>VGA_H_STRIDE/VGA_H_DIVISOR
  sta ZP_PTR+1

.aligned:

  ; Check for bank change
  lda ZP_PTR+1
  bne .nobankchange

  lda #>VRAM_BASE
  sta ZP_PTR+1

  ; Next bank
  ldy ZP_BANK
  iny
  sty ZP_BANK
  sty PORTB

.nobankchange

  lda ZP_VISIBLE
  ldy #VGA_H_VISIBLE / VGA_H_DIVISOR
  jsr vram_fill_block

  lda ZP_PORCH
  ldy #VGA_H_FPORCH / VGA_H_DIVISOR
  jsr vram_fill_block

  lda ZP_PORCH
  eor #BIT_HSYNC
  ldy #VGA_H_SYNC / VGA_H_DIVISOR
  jsr vram_fill_block

  lda ZP_PORCH
  ldy #VGA_H_BPORCH / VGA_H_DIVISOR
  jsr vram_fill_block

  ; Set HRESET flag on previous byte
  dec ZP_PTR+1
  ldy #$ff
  lda ZP_PORCH
  eor #BIT_HRESET
  sta (ZP_PTR),y
  inc ZP_PTR+1

  dex
  bne vram_fill_lines

  rts


vram_zeroall:
  ; Clear all video memory to zero
  ; Clear secondary memory (blue and green channels)
  ldx #0
  ldy #0
.loop1
  stx PORTB
  lda #<VRAM_BASE
  sta ZP_PTR
  lda #>VRAM_BASE
  sta ZP_PTR+1
  tya ; = 0
.loop2
  sta (ZP_PTR),y
  iny
  bne .loop2

  inc ZP_PTR+1
  bne .loop2
  
  inx
  cpx #8
  bne .loop1

  rts


vram_init:
  jsr vram_zeroall

  lda #<VRAM_BASE
  sta ZP_PTR
  lda #>VRAM_BASE
  sta ZP_PTR+1

  ; Set first bank
  lda #16
  sta ZP_BANK
  sta PORTB

  ; Normal lines
  lda #BITS_DEFAULT | BITS_PIXELDATA
  sta ZP_VISIBLE
  and #~BITS_PIXELDATA
  sta ZP_PORCH

  ldx #VGA_V_VISIBLE/VGA_V_DIVISOR/3
  jsr vram_fill_lines
  ldx #VGA_V_VISIBLE/VGA_V_DIVISOR/3
  jsr vram_fill_lines
  ; if it's too big, need to split into two chunks
  ldx #VGA_V_VISIBLE/VGA_V_DIVISOR - (VGA_V_VISIBLE/VGA_V_DIVISOR*2/3)
  jsr vram_fill_lines

  ; Vertical front porch
  lda #BITS_DEFAULT
  sta ZP_VISIBLE
  sta ZP_PORCH
  ldx #VGA_V_FPORCH/VGA_V_DIVISOR
  jsr vram_fill_lines

  ; Vertical sync
  lda #BITS_DEFAULT ^ BIT_VSYNC
  sta ZP_VISIBLE
  sta ZP_PORCH
  ldx #VGA_V_SYNC/VGA_V_DIVISOR
  jsr vram_fill_lines

  ; Vertical back porch
  lda #BITS_DEFAULT
  sta ZP_VISIBLE
  sta ZP_PORCH
  ldx #VGA_V_BPORCH/VGA_V_DIVISOR + 1
  jsr vram_fill_lines

  ; Set both reset flags on previous byte
  dec ZP_PTR+1
  ldy #$ff
  lda #BITS_DEFAULT ^ BIT_RESET ^ BIT_HRESET
  sta (ZP_PTR),y

  rts


vram_clear_black:
  lda #0

vram_clear:
.ZP_Y_HI = $0a

  ldx #8
  stx ZP_BANK
  stx PORTB

.planeloop
  ldx #<VRAM_BASE
  stx ZP_PTR
  ldx #>VRAM_BASE
  stx ZP_PTR+1

  ldx #>VRAM_HEIGHT
  inx
  stx .ZP_Y_HI
  ldx #<VRAM_HEIGHT
.loop

  ldy #VRAM_WIDTH
.loop2
  dey
  sta (ZP_PTR),y
  bne .loop2

  tay

  clc
  lda ZP_PTR
  adc #<VRAM_STRIDE
  sta ZP_PTR
  lda ZP_PTR+1
  adc #>VRAM_STRIDE
  sta ZP_PTR+1

  bcc .nobankchange

  lda #>VRAM_BASE
  sta ZP_PTR+1

  inc ZP_BANK
  lda ZP_BANK
  sta PORTB

.nobankchange

  tya

  dex
  bne .loop
  dec .ZP_Y_HI
  bne .loop

  ; Is it the first (non-control) plane?
  tax
  lda ZP_BANK
  and #8
  beq .done   ; No - then we're done

  ; Yes - then we need to clear the control plane next
  lda #16
  sta ZP_BANK
  sta PORTB

  ; Restore clear value, and set control bits appropriately
  txa
  and #BITS_PIXELDATA
  ora #BITS_DEFAULT

  jmp .planeloop

.done
  rts


vid_putpixel:
  ; Colour in A, coordinates in X and Y
  ; Tailored for 160x100x4bpp with 256 stride
  and #BITS_PIXELDATA
  ora #BITS_DEFAULT

  ; Set address low byte
  stx ZP_PTR
  tax

  ; Set bank
  tya
  rol
  rol
  and #1
  sta PORTB

  ; Set address high byte
  tya
  and #$7f
  clc
  adc #>VRAM_BASE
  sta ZP_PTR+1

  ; Write pixel data
  txa
  ldy #0
  sta (ZP_PTR),y
  rts

vram_openline:
  ; Y coordinate in A, high bit in Y
  ; Sets up ZP_PTR to point to start of line
  
  ; Set bank
  pha
  rol
  tya
  rol
  ;and #3
  sta PORTB
  pla

  ; Set address high byte
  and #$7f
  clc
  adc #>VRAM_BASE
  sta ZP_PTR+1

  ; Set address low byte
  lda #0
  sta ZP_PTR

  rts
 

vid_printchar
  ; A = character
  ; X,Y in ZP_TEXTPOS_X, ZP_TEXTPOS_Y

  sec
  sbc #$20
  rol
  rol
  rol
  sta ZP_PRINTCHAR_SRC
  rol
  and #3
  sta ZP_PRINTCHAR_SRC+1

  clc
  lda ZP_PRINTCHAR_SRC
  and #$f8
  adc #<fontbase
  sta ZP_PRINTCHAR_SRC
  lda ZP_PRINTCHAR_SRC+1
  adc #>fontbase
  sta ZP_PRINTCHAR_SRC+1

  ldy #8
  sty ZP_PRINTCHAR_DY

.yloop
  ldy ZP_PRINTCHAR_DY
  dey
  sty ZP_PRINTCHAR_DY
  bmi .yloopend

  lda (ZP_PRINTCHAR_SRC),y   ; 8 bits, left to right
  sta ZP_PRINTCHAR_BITS

  tya
  clc
  adc ZP_TEXTPOS_Y
  tax
  lda #0
  adc ZP_TEXTPOS_Y+1
  ora #4
  tay
  txa
  jsr vram_openline

  ; Draw one row of character.  At 640x480x3bpp, we need to do two passes - one for 
  ; the red channel (combining BITS_DEFAULT) and one for the green and blue channels 
  ; together.
  ;
  ; Each pass writes two bytes - four pixels each.

  ; For now, one pass only, blue and green channels.

  ldy ZP_TEXTPOS_X

  ; Get top four bits and replicate in low bits
  lda ZP_PRINTCHAR_BITS
  lsr
  lsr
  lsr
  lsr
  sta ZP_PRINTCHAR_BITS+1
  lda ZP_PRINTCHAR_BITS
  and #$f0
  ora ZP_PRINTCHAR_BITS+1

  sta (ZP_PTR),y

  iny

  ; Get bottom four bits and replicate in high bits
  lda ZP_PRINTCHAR_BITS
  asl
  asl
  asl
  asl
  sta ZP_PRINTCHAR_BITS+1
  lda ZP_PRINTCHAR_BITS
  and #$0f
  ora ZP_PRINTCHAR_BITS+1

  sta (ZP_PTR),y

  jmp .yloop

.yloopend

vid_textpos_moveright
  ldy ZP_TEXTPOS_X
  iny
  iny
  sty ZP_TEXTPOS_X
  cpy #160
  bcs vid_textpos_newline
  rts

vid_textpos_newline
  ldy #0
  sty ZP_TEXTPOS_X
vid_textpos_movedown
  clc
  lda ZP_TEXTPOS_Y
  adc #8
  sta ZP_TEXTPOS_Y
  bcc .nocarry
  inc ZP_TEXTPOS_Y+1
.nocarry
  cmp #<480
  bne .done

  ; Low byte was (maybe) match for 480 - check high byte as well
  lda ZP_TEXTPOS_Y+1
  cmp #>480
  bne .done
  
  ; We went off the bottom of the screen, move back up again instead
  sec
  lda ZP_TEXTPOS_Y
  sbc #8
  sta ZP_TEXTPOS_Y

  ; This will never borrow so there's no need to handle the high byte

.done
  rts



vid_printstringimm:
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

  jsr vid_printstring

  lda printmessage_bufferptr
  sta $103,x
  lda printmessage_bufferptr+1
  sta $104,x

  pla
  tax
  pla
  rts


vid_printstring:
  pha
  txa
  pha
  tya
  pha

  ldy #0
.loop:
  lda (printmessage_bufferptr),y
  beq .endloop

  sty ZP_PRINTSTRING_LOOPCOUNT

  jsr vid_printchar

  ldy ZP_PRINTSTRING_LOOPCOUNT
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


vid_printhex
  pha
  ror
  ror
  ror
  ror
  jsr vid_printhex_nybble
  pla
vid_printhex_nybble
  and #15
  cmp #10
  bmi .skipletter
  adc #6
.skipletter
  adc #48
  jsr vid_printchar
  rts



  .include lib/font.s

