  .org $8000

  .include lib/vga.s
  .include lib/random.s
  .include lib/lcd.s
  .include lib/via.s
  .include lib/libfat32.s
  .include lib/libsd.s
  .include lib/hwconfig.s

zp_sd_address = $40         ; 2 bytes
zp_sd_currentsector = $42   ; 4 bytes
zp_fat32_variables = $46    ; 24 bytes

fat32_workspace = $200      ; two pages

buffer = $400


reset:
  ldx #$ff
  txs

  jsr via_init
  jsr xvia_init
  jsr lcd_init

  jsr printimm
  .asciiz "Hello, World!"

  jsr vram_init

  jsr printimm
  .asciiz "A"

  ;jsr wait_button

  ldy #0
  sty ZP_TEXTPOS_X
  sty ZP_TEXTPOS_Y
  sty ZP_TEXTPOS_Y+1

  jsr vid_printstringimm
  .asciiz "Hello, World!"

  ;jsr wait_button

  jsr printimm
  .asciiz "B"


.buffer=$1000
.X = $10
.Y = $11

.testloop

  ldx #0
.initloop
  txa
  sta .buffer,x
  inx
  bne .initloop

  ldy #0
  sty .X
  sty .Y
  lda #$5a
.loop
  ldx .X
  adc .buffer,x
  tay
  adc .buffer,y
  adc #5
  sta .buffer,x
  
  inc .X
  bne .loop
  inc .Y
  bne .loop

  eor #$18
  bne .failed
  lda #'-'
  jsr vid_printchar
  jmp .testloop
.failed
  lda #'X'
  jsr vid_printchar
  jmp .testloop
  

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


  ; loop forever
loop:
  jmp loop




irq
  jsr printimm
  .asciiz "IRQ"
.dead
  jmp .dead


  .org $fffc
  .word reset
  .word $0000
