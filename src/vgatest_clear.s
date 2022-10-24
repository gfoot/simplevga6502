  .org $8000

  .include lib/vga.s
  .include lib/random.s
  .include lib/lcd.s
  .include lib/via.s
  .include lib/hwconfig.s

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

  ldx #0
  stx $80

.loop
  jsr wait_button

  inc $80
  lda $80
  jsr vram_clear
  jmp .loop


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
  .asciiz "Hello, World!"
.dead
  jmp .dead


  .org $fffc
  .word reset
  .word $0000
