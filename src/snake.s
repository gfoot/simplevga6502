  .org $e000

  .include lib/vga.s
  .include lib/random.s
  .include lib/lcd.s
  .include lib/via.s


POS_BUFFER = $1000
POS_BUFFER_END = $2000

HEADPTR = $40
TAILPTR = $42

APPLE_X = $44
APPLE_Y = $45

OLD_HEADPTR = $46

DIR_X = $50
DIR_Y = $51

SPEED = $52
SCORE = $53
PENDINGLENGTH = $54


BACKGROUND_COLOUR = 2
BORDER_COLOUR = 14
SNAKE_COLOUR = 15
APPLE_COLOUR = 12


reset:
  ldx #$ff
  txs

  jsr via_init
  jsr lcd_init
  jsr vram_init

  jsr printimm
  .asciiz "Welcome to Snake!"

  jsr init
  jsr run

stop
  jmp stop

run
.loop
  jsr wait
  jsr processcontrols
  jsr movesnake
  jsr drawapple
  jmp .loop


init
  lda #BACKGROUND_COLOUR
  jsr vram_clear

  ldx #0
  stx $80

.hlineloop
  lda #BORDER_COLOUR
  ldy #0
  ldx $80
  jsr vid_putpixel

  lda #BORDER_COLOUR
  ldy #VRAM_HEIGHT-1
  ldx $80
  jsr vid_putpixel
  
  ldx $80
  inx
  stx $80
  cpx #VRAM_WIDTH
  bne .hlineloop


  ldx #0
  stx $80

.vlineloop

  lda #14
  ldx #0
  ldy $80
  jsr vid_putpixel

  lda #14
  ldx #VRAM_WIDTH-1
  ldy $80
  jsr vid_putpixel
  
  ldx $80
  inx
  stx $80
  cpx #VRAM_HEIGHT
  bne .vlineloop


  lda #1
  sta DIR_X
  lda #0
  sta DIR_Y

  lda #VRAM_WIDTH/3
  sta POS_BUFFER
  lda #VRAM_HEIGHT/2
  sta POS_BUFFER+1

  lda #<POS_BUFFER
  sta TAILPTR
  sta HEADPTR
  lda #>POS_BUFFER
  sta TAILPTR+1
  sta HEADPTR+1

  ldx #5
.snakeinitloop
  inc HEADPTR
  inc HEADPTR
  ldy #0
  lda (TAILPTR),y
  sta (HEADPTR),y
  iny
  lda (TAILPTR),y
  sta (HEADPTR),y
  
  dex
  bne .snakeinitloop

  lda #0
  sta SCORE
  sta PENDINGLENGTH

  lda #10
  sta SPEED

  jsr placeapple

  rts


placeapple
  lda #VRAM_WIDTH-2
  jsr random_range
  clc
  adc #1
  sta APPLE_X
  lda #VRAM_HEIGHT-2
  jsr random_range
  clc
  adc #1
  sta APPLE_Y

drawapple
  lda #APPLE_COLOUR
  ldx APPLE_X
  ldy APPLE_Y
  jsr vid_putpixel

  rts


processcontrols
  ; Read control states from VIA
  lda PORTA

  ; Separate logic for when we're currently going horizontally or vertically
  ldx DIR_X
  beq .vertical

  ; Going horizontally, so only check up and down
  lsr
  bcc .downpressed
  lsr
  bcc .uppressed
  rts

.downpressed
  lda #1
  sta DIR_Y
  lda #0
  sta DIR_X
  rts

.uppressed
  lda #-1
  sta DIR_Y
  lda #0
  sta DIR_X
  rts

.vertical
  ; Going verticaly, so only check left and right
  lsr
  lsr
  lsr
  bcc .rightpressed
  lsr
  bcc .leftpressed
  rts

.rightpressed
  lda #1
  sta DIR_X
  lda #0
  sta DIR_Y
  rts

.leftpressed
  lda #$ff
  sta DIR_X
  lda #0
  sta DIR_Y
  rts


movesnake

  lda PENDINGLENGTH
  beq .movetail
  dec PENDINGLENGTH
  jmp .skipmovetail

.movetail
  ; Erase the tail
  ldy #0
  lda (TAILPTR),y
  tax
  iny
  lda (TAILPTR),y
  tay
  lda #BACKGROUND_COLOUR
  jsr vid_putpixel

  ; Advance the tail
  clc
  lda TAILPTR
  adc #2
  sta TAILPTR
  lda TAILPTR+1
  adc #0
  cmp #>POS_BUFFER_END
  bcc .aftertailadvance
  lda #>POS_BUFFER
.aftertailadvance
  sta TAILPTR+1

.skipmovetail

  ; Advance the head pointer
  clc
  lda HEADPTR
  sta OLD_HEADPTR
  adc #2
  sta HEADPTR
  lda HEADPTR+1
  sta OLD_HEADPTR+1
  adc #0
  cmp #>POS_BUFFER_END
  bcc .afterheadadvance
  lda #>POS_BUFFER
.afterheadadvance
  sta HEADPTR+1

  ; Calculate the new head position
  ldy #0
  lda (OLD_HEADPTR),y
  clc
  adc DIR_X
  sta (HEADPTR),y

  ldy #1
  lda (OLD_HEADPTR),y
  clc
  adc DIR_Y
  sta (HEADPTR),y

  ; Draw the new head
  ldy #0
  lda (HEADPTR),y
  tax
  iny
  lda (HEADPTR),y
  tay
  lda #SNAKE_COLOUR
  jsr vid_putpixel

  ; Eat apple?
  ldy #0
  lda (HEADPTR),y
  cmp APPLE_X
  bne .afterapplecheck
  iny
  lda (HEADPTR),y
  cmp APPLE_Y
  bne .afterapplecheck

  ; Place new apple
  jsr placeapple

  ; Eat the old apple
  inc PENDINGLENGTH
  inc PENDINGLENGTH

  inc SCORE
  jsr showscore

  lda SCORE
  and #3
  bne .afterapplecheck
  dec SPEED
  bne .afterapplecheck
  lda #1
  sta SPEED

.afterapplecheck
  rts


showscore
  jsr lcd_clear
  jsr printimm
  .asciiz "Score: "
  lda SCORE
  jsr print_hex
  rts


wait
  ldx SPEED
.loop
  jsr waitvsync
  dex
  bne .loop
  rts


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
  .word stop
