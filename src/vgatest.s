  .org $8000




imagedata_320100
  .binary data/320100.img

  .include lib/vga.s
  .include lib/random.s
  .include lib/lcd.s
  .include lib/via.s


reset:
  ldx #$ff
  txs

  jsr via_init

  jsr printimm
  .asciiz "Hello, World!"

  jsr vram_init
  jsr wait_button

  lda #0
  jsr vram_clear

  lda #0
  sta PORTB

  lda #1
  ora #BITS_DEFAULT
  sta VRAM_BASE+520
  sta VRAM_BASE+520+256
  sta VRAM_BASE+520+512
  sta VRAM_BASE+521+768
  sta VRAM_BASE+521+1024
  sta VRAM_BASE+521+1280

  lda #2
  ora #BITS_DEFAULT
  sta VRAM_BASE+530
  sta VRAM_BASE+530+256
  sta VRAM_BASE+530+512
  sta VRAM_BASE+531+768
  sta VRAM_BASE+531+1024
  sta VRAM_BASE+531+1280

  lda #3
  ora #BITS_DEFAULT
  sta VRAM_BASE+540
  sta VRAM_BASE+540+256
  sta VRAM_BASE+540+512
  sta VRAM_BASE+541+768
  sta VRAM_BASE+541+1024
  sta VRAM_BASE+541+1280

  jsr wait_button

B = VRAM_BASE + 560
  lda #2
  ora #BITS_DEFAULT
  sta B+0 + 256*0
  sta B+1 + 256*2
  sta B+2 + 256*4
  sta B+3 + 256*6
  sta B+4 + 256*8
  lda #1
  ora #BITS_DEFAULT
  sta B+0 + 256*1
  sta B+1 + 256*3
  sta B+2 + 256*5
  sta B+3 + 256*7
  sta B+4 + 256*9

  lda #8
  ora #BITS_DEFAULT
  sta B+0 + 256*0 + 5
  sta B+1 + 256*2 + 5
  sta B+2 + 256*4 + 5
  sta B+3 + 256*6 + 5
  sta B+4 + 256*8 + 5
  lda #4
  ora #BITS_DEFAULT
  sta B+0 + 256*1 + 5
  sta B+1 + 256*3 + 5
  sta B+2 + 256*5 + 5
  sta B+3 + 256*7 + 5
  sta B+4 + 256*9 + 5

  jsr wait_button

  ldx #0
.lp
  txa
  jsr vram_openline
  
  txa
  lsr
  tay

  lda #5
  bcs .noshift
  asl
.noshift
  ora #BITS_DEFAULT
 
  sta (ZP_PTR),y

  inx
  cpx #VRAM_HEIGHT
  bne .lp

  jsr wait_button

  ldx #0
.lp2
  txa
  jsr vram_openline
  
  txa
  and #BITS_PIXELDATA
  ora #BITS_DEFAULT

  ldy #VRAM_WIDTH
.lp3
  dey
  sta (ZP_PTR),y
  bne .lp3

  inx
  cpx #VRAM_HEIGHT
  bne .lp2

  jsr wait_button


.loop:

  ;jsr draw_rainbow
  ;jsr wait_button

  ;jsr draw_image_bw
  ;jsr wait_button

  jsr draw_image_320100
  jsr wait_button

  ;jsr vram_init
  jsr random
  jsr vram_clear
  jsr wait_button

  jmp .loop3

.loop6
  ldx #0
  stx $41
.loop5
  ldx #0
  stx $40
.loop4
  ldx $40
  ldy $41
  jsr random
  jsr vid_putpixel

  inc $40
  ldx $40
  cpx #VRAM_WIDTH
  bne .loop4

  inc $41
  ldx $41
  cpx #VRAM_HEIGHT
  bne .loop5

  ;jmp .loop6

.loop3
  lda #VRAM_WIDTH
  jsr random_range
  tax

  lda #VRAM_HEIGHT
  jsr random_range
  tay

  inc $20
  lda $20

  jsr vid_putpixel

  lda PORTA
  and #1
  bne .loop3

  jsr wait_button.buttonpressed
  jmp .loop


draw_rainbow:
.numcolours = 16
.baseaddress = (VRAM_BASE + VRAM_STRIDE * (VRAM_HEIGHT/2) + (VRAM_WIDTH - .numcolours) / 2)
  lda #<.baseaddress
  sta $0
  lda #>.baseaddress
  sta $1

  ldx #8
.outerloop:

  ldy #.numcolours-1
.loop:
  tya
  ora #BITS_DEFAULT
  sta ($0),y

  dey
  bpl .loop
  
  clc
  lda $0
  adc #<VRAM_STRIDE
  sta $0
  lda $1
  adc #>VRAM_STRIDE
  sta $1

  dex
  bne .outerloop

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


imagedata2:
;  .byte "........................................"
;  .byte "........................................"
;  .byte "........................................"
;  .byte "........................................"
;  .byte ".,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,."
;  .byte ".,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,."
;  .byte ".,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,."
;  .byte ".,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,."
;  .byte ".,====================================,."
;  .byte ".,====================================,."
;  .byte ".,= === ========  ====  ==============,."
;  .byte ".,= === ========= ===== ==============,."
;  .byte ".,= === ==   ==== ===== ====   =======,."
;  .byte ".,=     = === === ===== === === ======,."
;  .byte ".,= === =     === ===== === === ==  ==,."
;  .byte ".,= === = ======= ===== === === === ==,."
;  .byte ".,= === ==   ===   ===   ===   === ===,."
;  .byte ".,====================================,."
;  .byte ".,====================================,."
;  .byte ".,= === ==============  ======= === ==,."
;  .byte ".,= === =============== ======= === ==,."
;  .byte ".,= === ==   == =  ==== ====  = === ==,."
;  .byte ".,= = = = === =  == === === ==  === ==,."
;  .byte ".,= = = = === = ======= === === ======,."
;  .byte ".,= = = = === = ======= === === ======,."
;  .byte ".,== = ===   == ======   ===    === ==,."
;  .byte ".,====================================,."
;  .byte ".,====================================,."
;  .byte ".,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,."
;  .byte ".,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,."
;  .byte ".,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,."
;  .byte ".,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,."
;  .byte "........................................"
;  .byte "........................................"
;  .byte "........................................"
;  .byte "........................................"

imagedata:
;  .byte "........................................"
;  .byte "........................................"
;  .byte "........................................"
;  .byte "........................................"
;  .byte ".,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,."
;  .byte ".,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,."
;  .byte ".,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,."
;  .byte ".,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,."
;  .byte ".,,==================================,,."
;  .byte ".,,==================================,,."
;  .byte ".,,=== === =======  ==  =============,,."
;  .byte ".,,=== === ======== === =============,,."
;  .byte ".,,=== === ==   === === ===   =======,,."
;  .byte ".,,===     = === == === == === ======,,."
;  .byte ".,,=== === =     == === == === =  ===,,."
;  .byte ".,,=== === = ====== === == === == ===,,."
;  .byte ".,,=== === ==   ==   =   ==   == ====,,."
;  .byte ".,,==================================,,."
;  .byte ".,,==================================,,."
;  .byte ".,,== === =============  ====== == ==,,."
;  .byte ".,,== === ============== ====== == ==,,."
;  .byte ".,,== === ==   == =  === ===  = == ==,,."
;  .byte ".,,== = = = === =  == == == ==  == ==,,."
;  .byte ".,,== = = = === = ====== == === =====,,."
;  .byte ".,,== = = = === = ====== == === =====,,."
;  .byte ".,,=== = ===   == =====   ==    == ==,,."
;  .byte ".,,==================================,,."
;  .byte ".,,==================================,,."
;  .byte ".,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,."
;  .byte ".,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,."
;  .byte ".,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,."
;  .byte ".,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,."
;  .byte "........................................"
;  .byte "........................................"
;  .byte "........................................"
;  .byte "........................................"

imagedatabw:
  .byte $00,$00,$0f,$0f,$0f,$0b,$0f,$0f,$0f,$0f,$0f,$0e,$0f,$0f,$0e,$0f,$0b,$0b,$0f,$0f,$0f,$0b,$0f,$0f,$0e,$0f,$0f,$0f,$0b,$0f,$0f,$0f,$0e,$0f,$0f,$0f,$0e,$0e,$00,$00
  .byte $00,$00,$08,$00,$08,$0a,$00,$00,$00,$00,$00,$02,$08,$00,$02,$02,$08,$0a,$08,$00,$00,$08,$00,$08,$02,$0a,$00,$00,$08,$00,$00,$00,$0a,$08,$00,$00,$02,$02,$00,$00
  .byte $00,$00,$0a,$0f,$0b,$0b,$0f,$0f,$0e,$0f,$0f,$0a,$0f,$0f,$0b,$0e,$0e,$0e,$0e,$0f,$0f,$0b,$0f,$0b,$0e,$0a,$0f,$0e,$0f,$0f,$0f,$0f,$0a,$0f,$0f,$0b,$0b,$0e,$00,$00
  .byte $00,$00,$0a,$08,$02,$00,$00,$00,$02,$02,$00,$0a,$00,$00,$08,$00,$02,$00,$02,$08,$00,$02,$00,$02,$00,$02,$08,$08,$00,$08,$00,$00,$02,$00,$00,$08,$08,$02,$00,$00
  .byte $00,$00,$0e,$0b,$0e,$0f,$0f,$0f,$0b,$0b,$0b,$0b,$0f,$0f,$0b,$0f,$0b,$0f,$0e,$0f,$0b,$0f,$0b,$0f,$0f,$0e,$0e,$0f,$0f,$0b,$0b,$0f,$0f,$0f,$0f,$0b,$0f,$0a,$00,$00
  .byte $00,$00,$00,$0a,$00,$08,$00,$00,$08,$0a,$0a,$00,$00,$00,$02,$00,$00,$00,$00,$00,$08,$00,$08,$00,$00,$02,$00,$00,$00,$02,$08,$00,$00,$00,$00,$02,$00,$02,$00,$00
  .byte $00,$00,$0f,$0b,$0f,$0b,$0b,$0f,$0b,$0a,$0b,$0f,$0f,$0f,$0b,$0f,$0f,$0f,$0f,$0e,$0f,$0e,$0f,$0f,$0f,$0a,$0f,$0f,$0f,$0e,$0e,$0f,$0e,$0f,$0f,$0f,$0f,$0e,$00,$00
  .byte $00,$00,$08,$00,$00,$02,$02,$00,$02,$00,$08,$00,$00,$00,$0a,$00,$00,$00,$00,$02,$00,$02,$08,$00,$00,$08,$08,$00,$00,$00,$02,$08,$02,$00,$00,$00,$08,$00,$00,$00
  .byte $00,$00,$0e,$0f,$0f,$0f,$0b,$0f,$0e,$0f,$0b,$0f,$0f,$0b,$0b,$0e,$0f,$0f,$0f,$0b,$0f,$0a,$0f,$0f,$0e,$0f,$0f,$0b,$0f,$0f,$0e,$0f,$0b,$0f,$0f,$0e,$0b,$0e,$00,$00
  .byte $00,$00,$02,$00,$00,$00,$08,$00,$00,$08,$00,$00,$02,$02,$00,$02,$00,$00,$02,$08,$02,$02,$08,$00,$02,$00,$00,$02,$00,$00,$02,$00,$08,$00,$00,$02,$0a,$02,$00,$00
  .byte $00,$00,$0e,$0f,$0f,$0e,$0f,$0f,$0f,$0f,$0f,$0e,$0e,$0e,$0f,$0b,$0f,$0f,$0e,$0f,$0b,$0a,$0b,$0b,$0f,$0f,$0b,$0e,$0f,$0b,$0f,$0b,$0b,$0f,$0f,$0e,$0e,$0e,$00,$00
  .byte $00,$00,$08,$08,$00,$02,$08,$00,$00,$00,$00,$02,$0a,$08,$02,$08,$00,$00,$00,$00,$00,$0a,$02,$08,$00,$00,$02,$02,$08,$08,$00,$02,$02,$00,$00,$00,$00,$02,$00,$00
  .byte $00,$00,$0f,$0f,$0e,$0e,$0f,$0f,$0f,$0f,$0e,$0e,$0a,$0f,$0e,$0f,$0f,$0f,$0f,$0f,$0f,$0b,$0a,$0f,$0f,$0f,$0b,$0a,$0e,$0f,$0f,$0e,$0a,$0f,$0f,$0f,$0f,$0a,$00,$00
  .byte $00,$00,$00,$00,$00,$08,$00,$00,$00,$00,$00,$08,$08,$00,$00,$00,$02,$00,$00,$00,$00,$00,$0a,$00,$00,$00,$0a,$08,$02,$00,$02,$00,$0a,$08,$00,$00,$00,$08,$00,$00
  .byte $00,$00,$0f,$0f,$0f,$0b,$0f,$0f,$0b,$0f,$0f,$0b,$0f,$0f,$0f,$0f,$0e,$0f,$0f,$0f,$0f,$0f,$0a,$0f,$0f,$0f,$0a,$0f,$0e,$0f,$0b,$0f,$0b,$0e,$0f,$0f,$0e,$0e,$00,$00
  .byte $00,$00,$08,$00,$00,$02,$00,$00,$0a,$00,$00,$00,$02,$00,$00,$00,$00,$08,$00,$00,$00,$00,$02,$00,$00,$08,$00,$00,$00,$08,$08,$00,$00,$00,$08,$00,$02,$02,$00,$00
  .byte $00,$00,$0f,$0f,$0f,$0e,$0f,$0e,$0b,$0f,$0f,$0f,$0b,$0f,$0b,$0f,$0f,$0b,$0f,$0f,$0f,$0f,$0b,$0f,$0e,$0b,$0f,$0f,$0f,$0b,$0b,$0f,$0f,$0e,$0f,$0b,$0b,$0e,$00,$00
  .byte $00,$00,$08,$00,$00,$00,$00,$02,$08,$00,$00,$08,$08,$00,$02,$00,$00,$00,$00,$02,$08,$00,$08,$00,$02,$08,$02,$00,$00,$02,$02,$00,$00,$02,$00,$0a,$00,$02,$00,$00
  .byte $00,$00,$0f,$0e,$0f,$0f,$0f,$0a,$0f,$0f,$0e,$0a,$0f,$0f,$0e,$0f,$0f,$0f,$0f,$0e,$0b,$0b,$0f,$0f,$0e,$0f,$0b,$0b,$0f,$0b,$0e,$0f,$0f,$0e,$0f,$0b,$0b,$0e,$00,$00
  .byte $00,$00,$00,$02,$02,$00,$00,$0a,$00,$00,$02,$0a,$00,$00,$00,$00,$00,$08,$00,$00,$02,$08,$00,$00,$00,$00,$08,$0a,$00,$00,$00,$08,$00,$00,$08,$02,$0a,$00,$00,$00
  .byte $00,$00,$0f,$0e,$0e,$0f,$0f,$0e,$0f,$0b,$0e,$0f,$0f,$0f,$0f,$0e,$0e,$0f,$0f,$0f,$0e,$0f,$0f,$0f,$0f,$0b,$0f,$0a,$0f,$0f,$0f,$0b,$0f,$0f,$0b,$0a,$0e,$0e,$00,$00
  .byte $00,$00,$08,$00,$08,$00,$00,$02,$02,$02,$00,$00,$00,$00,$00,$02,$0a,$02,$00,$00,$00,$00,$00,$00,$00,$0a,$00,$02,$08,$00,$00,$00,$08,$08,$00,$0a,$00,$0a,$00,$00
  .byte $00,$00,$0f,$0e,$0f,$0f,$0f,$0b,$0e,$0e,$0f,$0b,$0f,$0f,$0f,$0e,$0b,$0b,$0f,$0b,$0e,$0f,$0f,$0f,$0f,$0a,$0f,$0b,$0b,$0f,$0f,$0e,$0e,$0f,$0b,$0a,$0f,$0a,$00,$00
  .byte $00,$00,$00,$02,$08,$00,$00,$08,$02,$08,$08,$02,$00,$00,$00,$00,$08,$08,$08,$02,$02,$08,$00,$00,$00,$00,$08,$0a,$00,$02,$00,$02,$00,$00,$0a,$02,$08,$00,$00,$00
  .byte $00,$00,$0f,$0e,$0f,$0b,$0e,$0e,$0e,$0e,$0b,$0e,$0e,$0e,$0f,$0f,$0b,$0b,$0b,$0e,$0e,$0f,$0f,$0f,$0f,$0f,$0e,$0b,$0f,$0e,$0e,$0f,$0f,$0f,$0a,$0e,$0f,$0e,$00,$00
  .byte $00,$00,$08,$00,$00,$02,$02,$02,$00,$02,$0a,$00,$0a,$0a,$08,$00,$0a,$00,$02,$00,$08,$00,$00,$00,$00,$00,$00,$08,$00,$00,$08,$08,$00,$00,$02,$08,$08,$02,$00,$00
  .byte $00,$00,$0f,$0f,$0f,$0e,$0b,$0e,$0f,$0e,$0f,$0f,$0b,$0a,$0e,$0e,$0b,$0f,$0e,$0f,$0f,$0f,$0f,$0f,$0f,$0f,$0e,$0f,$0f,$0b,$0f,$0b,$0e,$0e,$0f,$0b,$0b,$0e,$00,$00
  .byte $00,$00,$00,$00,$00,$00,$08,$02,$08,$00,$00,$00,$00,$02,$00,$0a,$08,$00,$02,$00,$00,$00,$00,$00,$00,$00,$02,$00,$00,$08,$00,$02,$02,$0a,$00,$08,$02,$00,$00,$00
  .byte $00,$00,$0f,$0b,$0f,$0f,$0f,$0e,$0f,$0f,$0e,$0f,$0f,$0b,$0f,$0b,$0b,$0f,$0e,$0f,$0e,$0f,$0f,$0b,$0f,$0f,$0b,$0f,$0e,$0f,$0f,$0f,$0b,$0b,$0e,$0f,$0b,$0e,$00,$00
  .byte $00,$00,$08,$08,$00,$02,$00,$00,$00,$00,$02,$00,$00,$08,$02,$00,$00,$00,$00,$08,$02,$08,$08,$08,$00,$00,$08,$00,$02,$00,$00,$00,$00,$00,$02,$00,$08,$02,$00,$00
  .byte $00,$00,$0b,$0e,$0f,$0a,$0f,$0f,$0f,$0f,$0b,$0f,$0e,$0f,$0e,$0f,$0f,$0f,$0e,$0e,$0e,$0e,$0b,$0f,$0f,$0f,$0f,$0e,$0b,$0f,$0f,$0b,$0f,$0f,$0b,$0a,$0f,$0e,$00,$00
  .byte $00,$00,$08,$02,$08,$08,$08,$00,$00,$00,$0a,$00,$02,$00,$00,$08,$00,$00,$02,$02,$08,$00,$08,$00,$00,$00,$00,$02,$08,$00,$00,$0a,$00,$00,$08,$0a,$00,$02,$00,$00
  .byte $00,$00,$0e,$0f,$0a,$0e,$0f,$0a,$0f,$0f,$0a,$0f,$0e,$0f,$0f,$0b,$0f,$0f,$0b,$0e,$0f,$0b,$0b,$0f,$0f,$0b,$0f,$0f,$0e,$0f,$0f,$0b,$0f,$0e,$0f,$0b,$0f,$0a,$00,$00
  .byte $00,$00,$0a,$00,$02,$02,$00,$0a,$08,$00,$00,$08,$00,$08,$00,$00,$02,$00,$00,$00,$00,$0a,$02,$00,$00,$08,$02,$00,$00,$08,$00,$02,$00,$02,$00,$00,$02,$02,$00,$00
  .byte $00,$00,$0b,$0f,$0b,$0f,$0b,$0b,$0b,$0f,$0e,$0b,$0f,$0f,$0f,$0f,$0e,$0f,$0f,$0f,$0f,$0b,$0f,$0f,$0e,$0f,$0b,$0e,$0f,$0b,$0e,$0e,$0f,$0b,$0f,$0f,$0b,$0e,$00,$00
  .byte $00,$00,$08,$00,$08,$00,$0a,$02,$02,$00,$02,$0a,$00,$00,$00,$08,$00,$08,$08,$00,$00,$00,$00,$00,$00,$00,$08,$00,$08,$02,$00,$08,$0a,$00,$00,$00,$0a,$00,$00,$00
  .byte $00,$00,$0b,$0e,$0b,$0e,$0e,$0f,$0e,$0f,$0e,$0f,$0b,$0f,$0e,$0b,$0f,$0b,$0b,$0f,$0f,$0f,$0f,$0f,$0f,$0e,$0f,$0e,$0b,$0f,$0f,$0f,$0a,$0f,$0f,$0f,$0b,$0e,$00,$00
  .byte $00,$00,$0a,$02,$0a,$02,$00,$00,$00,$08,$00,$00,$02,$00,$02,$02,$00,$00,$02,$00,$00,$00,$00,$02,$00,$02,$08,$02,$08,$00,$00,$00,$00,$08,$00,$00,$00,$02,$00,$00
  .byte $00,$00,$0b,$0b,$0b,$0b,$0f,$0e,$0f,$0f,$0f,$0f,$0e,$0e,$0b,$0b,$0f,$0f,$0f,$0e,$0f,$0f,$0f,$0b,$0f,$0a,$0e,$0e,$0f,$0e,$0f,$0f,$0e,$0f,$0e,$0f,$0f,$0e,$00,$00
  .byte $00,$00,$00,$08,$08,$08,$00,$02,$00,$00,$00,$00,$00,$0a,$08,$08,$00,$00,$00,$00,$08,$00,$00,$08,$00,$02,$00,$08,$00,$02,$08,$00,$02,$00,$02,$08,$00,$00,$00,$00
  .byte $00,$00,$0f,$0b,$0e,$0f,$0b,$0b,$0f,$0f,$0f,$0f,$0e,$0b,$0e,$0f,$0f,$0e,$0f,$0f,$0b,$0f,$0f,$0f,$0f,$0e,$0e,$0f,$0f,$0f,$0b,$0f,$0b,$0e,$0e,$0f,$0f,$0e,$00,$00
  .byte $00,$00,$0a,$00,$00,$00,$0a,$00,$00,$00,$00,$00,$02,$08,$00,$00,$00,$02,$08,$00,$00,$00,$00,$00,$08,$00,$0a,$00,$00,$00,$00,$00,$08,$02,$08,$00,$00,$02,$00,$00
  .byte $00,$00,$0a,$0f,$0f,$0e,$0b,$0f,$0f,$0f,$0f,$0e,$0e,$0f,$0f,$0f,$0f,$0a,$0f,$0f,$0f,$0f,$0f,$0b,$0b,$0f,$0b,$0f,$0f,$0b,$0f,$0f,$0b,$0e,$0f,$0f,$0e,$0a,$00,$00
  .byte $00,$00,$08,$08,$00,$08,$08,$00,$02,$00,$00,$00,$08,$00,$00,$02,$02,$02,$08,$00,$00,$00,$00,$08,$02,$00,$00,$00,$00,$0a,$00,$00,$02,$00,$00,$00,$02,$0a,$00,$00
  .byte $00,$00,$0f,$0b,$0e,$0f,$0f,$0f,$0e,$0f,$0f,$0f,$0b,$0f,$0f,$0b,$0b,$0e,$0f,$0f,$0f,$0b,$0f,$0b,$0e,$0f,$0f,$0f,$0f,$0b,$0f,$0f,$0f,$0f,$0f,$0f,$0e,$0e,$00,$00
  .byte $00,$00,$08,$00,$02,$00,$00,$00,$00,$08,$00,$00,$02,$00,$00,$08,$08,$00,$00,$00,$00,$0a,$00,$02,$00,$08,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$02,$00,$00
  .byte $00,$00,$0f,$0f,$0e,$0f,$0f,$0f,$0e,$0f,$0f,$0f,$0f,$0b,$0e,$0b,$0f,$0f,$0f,$0e,$0f,$0b,$0f,$0e,$0e,$0f,$0f,$0f,$0e,$0f,$0f,$0f,$0f,$0b,$0f,$0f,$0f,$0a,$00,$00
  .byte $00,$00,$08,$00,$00,$08,$00,$00,$02,$08,$00,$00,$00,$02,$02,$08,$00,$00,$00,$02,$00,$00,$08,$00,$02,$00,$00,$00,$02,$08,$00,$00,$00,$0a,$00,$00,$00,$08,$00,$00
  .byte $00,$00,$0b,$0f,$0f,$0b,$0f,$0f,$0e,$0f,$0b,$0b,$0f,$0e,$0e,$0f,$0f,$0e,$0f,$0b,$0f,$0e,$0f,$0f,$0f,$0f,$0f,$0f,$0a,$0e,$0f,$0f,$0a,$0e,$0f,$0f,$0e,$0e,$00,$00
  .byte $00,$00,$02,$00,$00,$02,$00,$00,$00,$00,$02,$0a,$00,$00,$08,$00,$00,$02,$00,$08,$00,$02,$00,$00,$00,$00,$00,$00,$02,$02,$02,$00,$0a,$00,$08,$00,$00,$02,$00,$00
  .byte $00,$00,$0e,$0e,$0f,$0f,$0f,$0f,$0f,$0f,$0e,$0e,$0f,$0f,$0b,$0f,$0f,$0e,$0f,$0b,$0f,$0e,$0f,$0f,$0f,$0f,$0f,$0f,$0f,$0b,$0b,$0b,$0f,$0f,$0b,$0f,$0f,$0e,$00,$00
  .byte $00,$00,$0a,$0a,$00,$00,$00,$00,$00,$00,$00,$00,$08,$00,$02,$00,$00,$00,$08,$02,$00,$00,$08,$00,$00,$00,$00,$00,$00,$00,$08,$0a,$00,$00,$02,$00,$00,$02,$00,$00
  .byte $00,$00,$0a,$0b,$0f,$0f,$0f,$0e,$0f,$0f,$0f,$0e,$0e,$0f,$0f,$0b,$0f,$0f,$0f,$0e,$0f,$0e,$0f,$0f,$0f,$0f,$0f,$0f,$0f,$0f,$0f,$0a,$0f,$0f,$0e,$0f,$0f,$0a,$00,$00
  .byte $00,$00,$08,$08,$00,$00,$00,$02,$08,$00,$00,$00,$02,$08,$00,$0a,$00,$08,$00,$00,$00,$0a,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$08,$00,$00,$0a,$00,$02,$00,$00
  .byte $00,$00,$0f,$0b,$0f,$0f,$0e,$0e,$0f,$0f,$0f,$0f,$0e,$0f,$0b,$0a,$0e,$0f,$0f,$0f,$0f,$0b,$0f,$0f,$0f,$0f,$0f,$0f,$0f,$0f,$0f,$0f,$0b,$0f,$0f,$0a,$0f,$0e,$00,$00
  .byte $00,$00,$00,$00,$02,$00,$00,$00,$08,$00,$00,$00,$00,$00,$02,$00,$0a,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$08,$00,$00,$00,$00,$02,$00,$00,$02,$08,$00,$00,$00
  .byte $00,$00,$0f,$0f,$0e,$0f,$0f,$0f,$0b,$0f,$0f,$0f,$0f,$0f,$0b,$0f,$0b,$0f,$0f,$0f,$0f,$0e,$0f,$0f,$0e,$0f,$0f,$0b,$0f,$0b,$0f,$0f,$0f,$0f,$0b,$0e,$0f,$0a,$00,$00
  .byte $00,$00,$0a,$00,$00,$08,$00,$00,$02,$00,$00,$00,$00,$00,$0a,$00,$00,$00,$00,$00,$00,$02,$08,$00,$02,$08,$00,$02,$00,$08,$00,$08,$00,$00,$08,$00,$00,$0a,$00,$00
  .byte $00,$00,$0a,$0f,$0f,$0b,$0f,$0b,$0e,$0b,$0f,$0f,$0f,$0f,$0b,$0b,$0f,$0f,$0e,$0f,$0f,$0b,$0b,$0f,$0e,$0f,$0f,$0b,$0e,$0f,$0e,$0f,$0f,$0e,$0e,$0f,$0f,$0a,$00,$00
  .byte $00,$00,$08,$08,$00,$00,$02,$08,$02,$0a,$00,$00,$00,$00,$00,$08,$00,$02,$08,$08,$00,$08,$02,$00,$08,$00,$00,$00,$02,$00,$02,$00,$00,$00,$02,$08,$00,$02,$00,$00
  .byte $00,$00,$0f,$0b,$0f,$0f,$0e,$0f,$0e,$0f,$0f,$0f,$0f,$0f,$0e,$0e,$0f,$0e,$0b,$0b,$0f,$0f,$0e,$0f,$0b,$0f,$0f,$0e,$0e,$0f,$0b,$0f,$0f,$0b,$0e,$0f,$0b,$0e,$00,$00
  .byte $00,$00,$08,$00,$00,$08,$00,$00,$00,$00,$00,$00,$00,$00,$02,$02,$08,$00,$02,$02,$00,$00,$00,$00,$02,$00,$00,$02,$08,$08,$00,$00,$00,$0a,$00,$00,$08,$02,$00,$00
  .byte $00,$00,$0f,$0f,$0e,$0f,$0f,$0f,$0f,$0b,$0f,$0f,$0f,$0f,$0e,$0e,$0f,$0f,$0a,$0f,$0e,$0f,$0f,$0f,$0e,$0f,$0f,$0b,$0b,$0f,$0f,$0f,$0e,$0b,$0f,$0f,$0f,$0e,$00,$00
  .byte $00,$00,$00,$00,$02,$00,$00,$00,$00,$0a,$00,$00,$00,$00,$00,$08,$00,$00,$0a,$00,$00,$08,$00,$00,$00,$08,$08,$00,$02,$00,$00,$02,$02,$08,$00,$00,$00,$02,$00,$00
  .byte $00,$00,$0f,$0f,$0e,$0f,$0e,$0f,$0f,$0b,$0f,$0f,$0e,$0f,$0f,$0b,$0f,$0f,$0a,$0f,$0f,$0b,$0e,$0f,$0f,$0a,$0f,$0f,$0f,$0f,$0f,$0a,$0e,$0f,$0f,$0b,$0f,$0a,$00,$00
  .byte $00,$00,$08,$00,$00,$08,$02,$08,$00,$00,$00,$00,$02,$08,$00,$02,$00,$00,$0a,$08,$00,$00,$0a,$00,$00,$0a,$00,$00,$00,$00,$00,$02,$08,$02,$00,$0a,$00,$08,$00,$00
  .byte $00,$00,$0e,$0f,$0f,$0e,$0b,$0b,$0f,$0b,$0f,$0f,$0e,$0b,$0f,$0e,$0f,$0b,$0b,$0b,$0f,$0e,$0b,$0e,$0e,$0f,$0f,$0f,$0e,$0f,$0f,$0e,$0b,$0a,$0f,$0a,$0e,$0e,$00,$00
  .byte $00,$00,$02,$08,$00,$02,$08,$02,$00,$02,$00,$00,$00,$0a,$08,$00,$02,$02,$00,$02,$00,$02,$08,$02,$0a,$00,$00,$00,$00,$08,$00,$08,$02,$08,$08,$02,$08,$02,$00,$00
  .byte $00,$00,$0e,$0b,$0f,$0e,$0f,$0f,$0b,$0e,$0f,$0f,$0b,$0a,$0f,$0f,$0b,$0b,$0f,$0b,$0e,$0b,$0b,$0a,$0b,$0f,$0f,$0f,$0f,$0b,$0f,$0b,$0a,$0e,$0f,$0f,$0b,$0e,$00,$00
  .byte $00,$00,$08,$02,$00,$00,$08,$00,$0a,$00,$00,$00,$0a,$00,$00,$00,$08,$08,$00,$0a,$02,$08,$02,$02,$08,$02,$00,$00,$00,$02,$00,$02,$0a,$02,$00,$00,$02,$02,$00,$00
  .byte $00,$00,$0f,$0b,$0e,$0f,$0f,$0e,$0f,$0f,$0f,$0e,$0f,$0f,$0f,$0e,$0e,$0f,$0e,$0a,$0e,$0b,$0f,$0e,$0e,$0e,$0f,$0f,$0b,$0f,$0e,$0e,$0e,$0b,$0e,$0f,$0e,$0e,$00,$00
  .byte $00,$00,$00,$0a,$02,$00,$00,$00,$00,$00,$00,$02,$00,$00,$00,$02,$02,$08,$00,$08,$08,$0a,$00,$00,$02,$08,$08,$00,$0a,$00,$00,$08,$00,$08,$02,$08,$00,$08,$00,$00
  .byte $00,$00,$0f,$0a,$0e,$0f,$0f,$0f,$0b,$0f,$0f,$0b,$0f,$0b,$0f,$0f,$0e,$0f,$0f,$0f,$0b,$0b,$0f,$0f,$0e,$0e,$0b,$0e,$0b,$0e,$0e,$0f,$0b,$0f,$0f,$0b,$0f,$0e,$00,$00
  .byte $00,$00,$08,$02,$08,$08,$00,$00,$08,$02,$00,$08,$00,$0a,$00,$00,$00,$00,$00,$00,$02,$00,$00,$00,$00,$02,$0a,$00,$08,$00,$0a,$00,$0a,$00,$00,$00,$00,$02,$00,$00
  .byte $00,$00,$0e,$0e,$0f,$0b,$0f,$0e,$0b,$0e,$0f,$0f,$0b,$0b,$0f,$0b,$0f,$0f,$0f,$0f,$0b,$0f,$0f,$0f,$0f,$0e,$0b,$0f,$0f,$0f,$0a,$0f,$0b,$0b,$0f,$0f,$0f,$0a,$00,$00
  .byte $00,$00,$02,$00,$08,$00,$00,$02,$0a,$00,$00,$00,$02,$00,$00,$02,$00,$00,$00,$00,$08,$00,$08,$00,$00,$00,$08,$00,$00,$00,$02,$08,$00,$02,$00,$00,$00,$08,$00,$00
  .byte $00,$00,$0b,$0e,$0f,$0f,$0f,$0e,$0b,$0f,$0f,$0f,$0f,$0f,$0f,$0b,$0e,$0f,$0f,$0f,$0b,$0e,$0e,$0f,$0b,$0e,$0f,$0e,$0f,$0f,$0e,$0f,$0f,$0b,$0f,$0b,$0e,$0e,$00,$00
  .byte $00,$00,$08,$02,$00,$00,$00,$00,$08,$08,$00,$00,$00,$00,$00,$08,$02,$08,$00,$00,$02,$02,$00,$08,$0a,$02,$00,$02,$08,$00,$00,$00,$08,$08,$02,$02,$02,$02,$00,$00
  .byte $00,$00,$0b,$0e,$0f,$0f,$0f,$0e,$0e,$0f,$0f,$0f,$0b,$0b,$0f,$0e,$0e,$0f,$0f,$0f,$0e,$0b,$0f,$0a,$0e,$0b,$0f,$0e,$0f,$0f,$0e,$0e,$0b,$0e,$0e,$0e,$0f,$0e,$00,$00
  .byte $00,$00,$0a,$00,$08,$00,$00,$02,$02,$00,$00,$00,$02,$08,$00,$02,$08,$00,$00,$00,$00,$08,$00,$02,$00,$08,$00,$00,$00,$00,$02,$0a,$02,$00,$08,$08,$00,$02,$00,$00
  .byte $00,$00,$0e,$0f,$0b,$0b,$0e,$0f,$0e,$0f,$0f,$0f,$0e,$0f,$0f,$0b,$0b,$0f,$0e,$0f,$0f,$0f,$0f,$0e,$0f,$0f,$0f,$0e,$0b,$0f,$0e,$0b,$0e,$0f,$0a,$0f,$0b,$0a,$00,$00
  .byte $00,$00,$08,$02,$08,$0a,$02,$08,$00,$08,$00,$00,$00,$00,$00,$08,$02,$00,$02,$00,$00,$00,$0a,$02,$00,$00,$02,$02,$0a,$00,$00,$08,$00,$08,$02,$00,$0a,$02,$00,$00
  .byte $00,$00,$0f,$0a,$0e,$0f,$0b,$0e,$0f,$0b,$0f,$0f,$0f,$0e,$0e,$0f,$0f,$0f,$0b,$0f,$0b,$0e,$0a,$0f,$0f,$0f,$0e,$0f,$0b,$0f,$0b,$0f,$0f,$0f,$0f,$0b,$0b,$0a,$00,$00
  .byte $00,$00,$00,$0a,$02,$00,$00,$00,$08,$00,$0a,$00,$00,$00,$0a,$02,$00,$00,$00,$00,$0a,$02,$02,$00,$00,$00,$00,$00,$00,$00,$08,$00,$00,$00,$00,$02,$00,$0a,$00,$00
  .byte $00,$00,$0e,$0b,$0b,$0f,$0f,$0f,$0f,$0f,$0a,$0f,$0f,$0f,$0b,$0a,$0f,$0f,$0f,$0f,$0a,$0f,$0e,$0f,$0f,$0f,$0f,$0f,$0f,$0f,$0b,$0f,$0f,$0f,$0f,$0e,$0f,$0a,$00,$00
  .byte $00,$00,$08,$08,$00,$00,$00,$00,$00,$00,$00,$08,$00,$00,$00,$08,$08,$00,$00,$00,$02,$00,$00,$08,$00,$00,$00,$00,$00,$00,$02,$00,$00,$00,$00,$00,$08,$02,$00,$00
  .byte $00,$00,$0f,$0b,$0f,$0f,$0f,$0f,$0f,$0f,$0f,$0b,$0f,$0b,$0f,$0b,$0b,$0f,$0f,$0f,$0b,$0f,$0f,$0b,$0f,$0f,$0f,$0f,$0f,$0b,$0f,$0e,$0f,$0f,$0f,$0f,$0b,$0e,$00,$00
  .byte $00,$00,$08,$02,$00,$00,$00,$00,$00,$00,$08,$00,$02,$02,$00,$02,$02,$00,$00,$00,$08,$00,$08,$00,$00,$00,$00,$00,$00,$0a,$00,$02,$00,$08,$02,$00,$02,$00,$00,$00
  .byte $00,$00,$0f,$0b,$0f,$0b,$0f,$0f,$0f,$0f,$0b,$0f,$0b,$0f,$0e,$0f,$0f,$0f,$0f,$0e,$0f,$0e,$0f,$0f,$0f,$0f,$0f,$0f,$0e,$0b,$0f,$0a,$0f,$0b,$0e,$0f,$0e,$0e,$00,$00
  .byte $00,$00,$00,$0a,$00,$08,$08,$00,$00,$00,$02,$00,$08,$00,$02,$00,$00,$00,$00,$08,$00,$02,$00,$00,$00,$00,$00,$00,$02,$0a,$00,$02,$08,$00,$00,$08,$00,$08,$00,$00
  .byte $00,$00,$0f,$0b,$0e,$0e,$0f,$0f,$0e,$0f,$0f,$0e,$0f,$0f,$0b,$0f,$0b,$0f,$0f,$0b,$0b,$0e,$0f,$0f,$0f,$0e,$0f,$0f,$0e,$0e,$0f,$0e,$0f,$0b,$0f,$0b,$0f,$0e,$00,$00
  .byte $00,$00,$08,$00,$00,$02,$00,$00,$00,$08,$00,$00,$00,$00,$08,$00,$08,$00,$00,$02,$0a,$00,$02,$00,$00,$0a,$08,$00,$00,$00,$08,$00,$08,$0a,$00,$00,$00,$02,$00,$00
  .byte $00,$00,$0e,$0f,$0f,$0b,$0f,$0f,$0f,$0b,$0f,$0f,$0f,$0b,$0b,$0e,$0f,$0b,$0e,$0e,$0b,$0f,$0b,$0f,$0b,$0a,$0e,$0f,$0f,$0f,$0b,$0b,$0e,$0a,$0f,$0f,$0f,$0e,$00,$00
  .byte $00,$00,$02,$08,$00,$08,$00,$00,$00,$02,$00,$00,$00,$0a,$02,$00,$00,$0a,$02,$08,$08,$00,$08,$00,$02,$08,$02,$08,$00,$00,$02,$02,$00,$0a,$02,$00,$00,$02,$00,$00
  .byte $00,$00,$0e,$0f,$0a,$0b,$0f,$0f,$0b,$0e,$0f,$0f,$0b,$0b,$0b,$0f,$0e,$0e,$0b,$0a,$0f,$0f,$0b,$0f,$0a,$0b,$0e,$0f,$0b,$0f,$0f,$0f,$0b,$0b,$0e,$0f,$0f,$0e,$00,$00
  .byte $00,$00,$08,$00,$0a,$0a,$00,$00,$0a,$00,$08,$00,$0a,$02,$08,$00,$08,$00,$08,$02,$00,$00,$02,$00,$0a,$02,$00,$00,$08,$00,$00,$00,$02,$00,$00,$08,$00,$00,$00,$00
  .byte $00,$00,$0b,$0f,$0b,$0e,$0f,$0e,$0e,$0f,$0b,$0f,$0b,$0a,$0f,$0e,$0f,$0f,$0f,$0f,$0f,$0f,$0e,$0b,$0b,$0b,$0b,$0e,$0f,$0f,$0f,$0f,$0b,$0f,$0f,$0b,$0f,$0e,$00,$00
  .byte $00,$00,$0a,$00,$00,$00,$00,$08,$00,$08,$00,$00,$00,$0a,$00,$02,$02,$00,$00,$00,$00,$08,$00,$0a,$00,$08,$08,$0a,$00,$00,$08,$00,$0a,$00,$00,$02,$00,$00,$00,$00
  .byte $00,$00,$0b,$0f,$0e,$0f,$0f,$0b,$0f,$0f,$0f,$0f,$0f,$0b,$0f,$0b,$0b,$0f,$0e,$0f,$0e,$0f,$0e,$0f,$0f,$0e,$0f,$0b,$0f,$0e,$0f,$0b,$0b,$0e,$0f,$0e,$0f,$0e,$00,$00
  .byte $00,$00,$08,$00,$02,$08,$08,$02,$00,$00,$00,$00,$00,$00,$00,$00,$08,$00,$02,$00,$02,$00,$02,$00,$00,$02,$00,$00,$00,$02,$00,$02,$00,$02,$08,$02,$08,$02,$00,$00
  .byte $00,$00,$0f,$0f,$0e,$0e,$0b,$0e,$0b,$0f,$0f,$0f,$0f,$0f,$0e,$0f,$0b,$0f,$0e,$0e,$0f,$0f,$0b,$0f,$0e,$0f,$0f,$0f,$0f,$0a,$0f,$0e,$0f,$0e,$0b,$0b,$0e,$0e,$00,$00
  .byte $00,$00,$00,$00,$00,$0a,$02,$00,$0a,$00,$00,$08,$00,$00,$02,$08,$02,$00,$00,$0a,$08,$00,$00,$00,$02,$00,$00,$00,$00,$02,$08,$00,$08,$00,$08,$08,$00,$0a,$00,$00
  .byte $00,$00,$0f,$0f,$0f,$0b,$0b,$0e,$0f,$0f,$0e,$0f,$0f,$0b,$0f,$0b,$0e,$0f,$0f,$0a,$0f,$0f,$0f,$0f,$0b,$0f,$0f,$0e,$0f,$0e,$0f,$0a,$0e,$0f,$0f,$0e,$0f,$0a,$00,$00
  .byte $00,$00,$08,$00,$00,$00,$08,$02,$00,$00,$08,$00,$00,$08,$00,$00,$08,$00,$00,$0a,$00,$00,$02,$00,$08,$00,$00,$02,$08,$00,$00,$0a,$02,$00,$00,$00,$08,$00,$00,$00
  .byte $00,$00,$0f,$0f,$0b,$0e,$0f,$0e,$0f,$0b,$0b,$0f,$0e,$0f,$0f,$0e,$0b,$0f,$0f,$0b,$0f,$0f,$0e,$0f,$0f,$0f,$0f,$0a,$0f,$0f,$0f,$0b,$0e,$0f,$0f,$0e,$0f,$0e,$00,$00
  .byte $00,$00,$00,$00,$0a,$00,$00,$00,$08,$08,$02,$00,$02,$00,$08,$02,$0a,$00,$00,$08,$00,$00,$00,$00,$00,$00,$00,$02,$00,$08,$00,$00,$08,$08,$00,$02,$00,$02,$00,$00
  .byte $00,$00,$0f,$0f,$0b,$0f,$0f,$0f,$0b,$0f,$0e,$0f,$0b,$0e,$0e,$0e,$0e,$0f,$0f,$0b,$0f,$0f,$0f,$0f,$0f,$0f,$0f,$0b,$0f,$0b,$0f,$0e,$0f,$0b,$0b,$0e,$0f,$0a,$00,$00
  .byte $00,$00,$08,$00,$00,$00,$08,$08,$00,$00,$00,$08,$08,$02,$00,$08,$00,$00,$08,$02,$00,$00,$00,$02,$00,$00,$00,$08,$00,$02,$00,$02,$00,$02,$08,$08,$08,$0a,$00,$00
  .byte $00,$00,$0f,$0f,$0f,$0e,$0e,$0b,$0f,$0f,$0f,$0b,$0b,$0f,$0e,$0f,$0f,$0e,$0e,$0b,$0e,$0f,$0b,$0b,$0f,$0e,$0b,$0b,$0f,$0e,$0f,$0b,$0f,$0e,$0e,$0f,$0a,$0e,$00,$00
  .byte $00,$00,$00,$00,$00,$02,$00,$0a,$00,$00,$00,$02,$00,$00,$02,$00,$00,$02,$02,$08,$02,$02,$02,$08,$00,$02,$0a,$02,$00,$00,$08,$00,$00,$00,$02,$00,$02,$02,$00,$00
  .byte $00,$00,$0f,$0f,$0f,$0b,$0e,$0f,$0b,$0f,$0f,$0b,$0f,$0e,$0f,$0f,$0f,$0e,$0f,$0f,$0b,$0e,$0e,$0f,$0f,$0b,$0b,$0b,$0b,$0f,$0f,$0f,$0f,$0b,$0a,$0f,$0f,$0e,$00,$00
  .byte $00,$00,$02,$08,$00,$00,$02,$00,$02,$00,$00,$0a,$00,$02,$00,$00,$00,$00,$00,$00,$00,$08,$08,$00,$00,$08,$00,$08,$08,$00,$00,$00,$08,$08,$0a,$00,$02,$00,$00,$00
  .byte $00,$00,$0e,$0b,$0f,$0f,$0e,$0f,$0e,$0f,$0f,$0b,$0f,$0b,$0f,$0f,$0f,$0f,$0f,$0f,$0f,$0b,$0b,$0f,$0b,$0f,$0f,$0e,$0f,$0f,$0f,$0b,$0b,$0f,$0b,$0f,$0b,$0e,$00,$00
  .byte $00,$00,$08,$0a,$00,$00,$00,$08,$00,$08,$00,$00,$00,$00,$00,$00,$08,$02,$00,$00,$00,$02,$02,$00,$0a,$00,$00,$00,$00,$02,$00,$0a,$00,$00,$02,$00,$08,$00,$00,$00
  .byte $00,$00,$0e,$0b,$0f,$0f,$0b,$0f,$0e,$0f,$0f,$0f,$0f,$0f,$0b,$0e,$0b,$0b,$0b,$0f,$0f,$0b,$0f,$0e,$0b,$0b,$0f,$0f,$0f,$0e,$0e,$0e,$0f,$0b,$0b,$0e,$0f,$0e,$00,$00
  .byte $00,$00,$0a,$08,$00,$00,$08,$00,$02,$00,$00,$00,$00,$00,$0a,$02,$02,$08,$02,$00,$00,$08,$00,$00,$08,$02,$00,$00,$00,$00,$0a,$00,$08,$0a,$08,$00,$00,$02,$00,$00
  .byte $00,$00,$0a,$0f,$0e,$0e,$0f,$0b,$0e,$0e,$0f,$0f,$0f,$0f,$0b,$0b,$0e,$0f,$0b,$0f,$0e,$0f,$0f,$0f,$0b,$0e,$0f,$0f,$0f,$0e,$0b,$0f,$0a,$0a,$0f,$0f,$0f,$0e,$00,$00
  .byte $00,$00,$02,$00,$02,$02,$00,$0a,$00,$08,$08,$00,$00,$00,$00,$08,$00,$00,$0a,$00,$02,$00,$00,$00,$0a,$00,$00,$00,$00,$0a,$08,$00,$02,$0a,$00,$00,$00,$02,$00,$00
  .byte $00,$00,$0e,$0f,$0f,$0e,$0f,$0b,$0e,$0f,$0f,$0f,$0b,$0f,$0f,$0b,$0e,$0b,$0a,$0f,$0b,$0f,$0e,$0f,$0b,$0e,$0f,$0f,$0f,$0a,$0f,$0e,$0f,$0e,$0f,$0f,$0f,$0e,$00,$00
  .byte $00,$00,$08,$00,$00,$00,$08,$02,$02,$00,$00,$00,$0a,$00,$00,$02,$02,$0a,$00,$08,$08,$00,$02,$00,$00,$02,$08,$00,$00,$02,$00,$0a,$00,$00,$02,$00,$00,$00,$00,$00
  .byte $00,$00,$0f,$0f,$0f,$0f,$0b,$0e,$0b,$0f,$0b,$0e,$0b,$0f,$0f,$0e,$0e,$0b,$0f,$0a,$0f,$0f,$0b,$0f,$0f,$0f,$0b,$0f,$0f,$0a,$0e,$0b,$0f,$0f,$0b,$0f,$0f,$0e,$00,$00
  .byte $00,$00,$08,$00,$00,$00,$02,$00,$08,$00,$08,$0a,$08,$08,$00,$00,$08,$08,$00,$02,$00,$00,$08,$00,$00,$00,$02,$00,$00,$0a,$0a,$02,$00,$00,$08,$00,$00,$02,$00,$00
  .byte $00,$00,$0f,$0f,$0f,$0e,$0f,$0f,$0f,$0b,$0b,$0a,$0e,$0b,$0e,$0f,$0b,$0f,$0f,$0f,$0f,$0e,$0f,$0f,$0f,$0f,$0e,$0f,$0e,$0a,$0b,$0b,$0b,$0e,$0f,$0f,$0e,$0e,$00,$00
  .byte $00,$00,$00,$00,$00,$02,$00,$00,$00,$02,$02,$00,$02,$02,$02,$08,$00,$02,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$02,$08,$08,$08,$02,$02,$00,$00,$02,$08,$00,$00
  .byte $00,$00,$0f,$0f,$0f,$0b,$0f,$0f,$0f,$0e,$0f,$0f,$0b,$0a,$0e,$0f,$0f,$0b,$0f,$0f,$0f,$0f,$0f,$0f,$0f,$0f,$0f,$0e,$0e,$0e,$0e,$0f,$0e,$0e,$0f,$0f,$0e,$0a,$00,$00
  .byte $00,$00,$08,$00,$00,$08,$00,$00,$00,$00,$08,$02,$00,$0a,$08,$00,$00,$08,$00,$00,$00,$08,$00,$00,$08,$00,$00,$02,$0a,$02,$02,$00,$00,$08,$08,$00,$00,$0a,$00,$00
  .byte $00,$00,$0b,$0f,$0f,$0f,$0f,$0b,$0f,$0f,$0b,$0b,$0f,$0a,$0f,$0f,$0e,$0b,$0f,$0f,$0e,$0f,$0b,$0f,$0b,$0b,$0f,$0f,$0b,$0b,$0b,$0b,$0f,$0b,$0f,$0e,$0f,$0a,$00,$00
  .byte $00,$00,$02,$00,$00,$00,$00,$0a,$00,$00,$02,$00,$00,$02,$00,$00,$02,$0a,$00,$00,$0a,$00,$0a,$00,$02,$08,$00,$00,$00,$08,$08,$0a,$00,$00,$00,$02,$08,$02,$00,$00
  .byte $00,$00,$0e,$0f,$0f,$0f,$0f,$0a,$0f,$0e,$0f,$0f,$0b,$0f,$0e,$0f,$0e,$0f,$0e,$0e,$0a,$0f,$0b,$0f,$0e,$0f,$0f,$0f,$0e,$0e,$0f,$0b,$0b,$0f,$0f,$0e,$0b,$0e,$00,$00
  .byte $00,$00,$08,$00,$00,$00,$08,$02,$00,$02,$08,$02,$0a,$00,$02,$08,$00,$00,$00,$0a,$02,$08,$00,$00,$00,$00,$00,$00,$02,$00,$00,$00,$0a,$08,$00,$00,$0a,$02,$00,$00
  .byte $00,$00,$0f,$0f,$0f,$0e,$0b,$0e,$0f,$0e,$0b,$0e,$0a,$0e,$0e,$0f,$0f,$0f,$0f,$0b,$0e,$0b,$0f,$0f,$0f,$0b,$0f,$0f,$0b,$0f,$0f,$0f,$0a,$0f,$0b,$0f,$0a,$0e,$00,$00
  .byte $00,$00,$08,$00,$00,$02,$02,$00,$08,$00,$0a,$00,$02,$02,$08,$00,$00,$00,$00,$00,$00,$0a,$00,$00,$00,$02,$00,$08,$00,$00,$00,$00,$00,$00,$0a,$00,$00,$0a,$00,$00
  .byte $00,$00,$0f,$0f,$0f,$0b,$0e,$0f,$0f,$0f,$0b,$0f,$0f,$0e,$0f,$0f,$0e,$0f,$0f,$0f,$0f,$0b,$0f,$0f,$0f,$0e,$0e,$0f,$0f,$0f,$0f,$0f,$0e,$0f,$0b,$0f,$0f,$0a,$00,$00
  .byte $00,$00,$00,$00,$00,$08,$00,$00,$00,$00,$00,$00,$00,$02,$00,$00,$02,$08,$00,$00,$00,$00,$00,$02,$00,$00,$08,$00,$02,$00,$00,$00,$02,$08,$00,$00,$00,$02,$00,$00
  .byte $00,$00,$0f,$0f,$0f,$0b,$0f,$0f,$0f,$0f,$0f,$0f,$0e,$0f,$0f,$0f,$0a,$0f,$0e,$0f,$0f,$0f,$0f,$0b,$0f,$0f,$0b,$0f,$0e,$0f,$0e,$0f,$0e,$0e,$0f,$0f,$0f,$0e,$00,$00
  .byte $00,$00,$08,$00,$00,$02,$00,$00,$00,$00,$00,$00,$02,$00,$00,$00,$02,$00,$02,$02,$00,$00,$00,$08,$00,$00,$0a,$00,$00,$08,$00,$08,$00,$02,$08,$00,$00,$00,$00,$00
  .byte $00,$00,$0f,$0b,$0b,$0f,$0f,$0f,$0e,$0f,$0f,$0f,$0e,$0f,$0b,$0f,$0e,$0f,$0b,$0b,$0f,$0e,$0e,$0f,$0e,$0f,$0b,$0e,$0e,$0f,$0f,$0b,$0b,$0e,$0e,$0f,$0f,$0e,$00,$00
  .byte $00,$00,$00,$0a,$02,$00,$00,$00,$02,$00,$08,$00,$00,$08,$0a,$02,$00,$00,$08,$0a,$00,$02,$08,$00,$02,$08,$00,$02,$08,$08,$00,$02,$02,$08,$00,$08,$00,$02,$00,$00
  .byte $00,$00,$0b,$0b,$0f,$0f,$0f,$0f,$0b,$0e,$0f,$0f,$0f,$0b,$0e,$0e,$0f,$0e,$0e,$0b,$0e,$0e,$0f,$0f,$0e,$0e,$0e,$0e,$0f,$0b,$0f,$0f,$0e,$0f,$0f,$0f,$0e,$0e,$00,$00
  .byte $00,$00,$0a,$02,$00,$00,$02,$00,$00,$02,$00,$00,$00,$00,$00,$00,$08,$02,$08,$08,$02,$08,$08,$00,$00,$02,$0a,$08,$08,$02,$00,$00,$00,$00,$00,$00,$00,$08,$00,$00
  .byte $00,$00,$0b,$0b,$0e,$0e,$0e,$0f,$0f,$0b,$0f,$0f,$0f,$0f,$0f,$0f,$0e,$0e,$0f,$0b,$0e,$0b,$0b,$0f,$0b,$0f,$0a,$0b,$0b,$0f,$0f,$0f,$0f,$0e,$0f,$0f,$0e,$0e,$00,$00
  .byte $00,$00,$08,$08,$00,$0a,$00,$08,$00,$08,$00,$00,$00,$00,$00,$00,$00,$08,$08,$00,$00,$0a,$00,$08,$08,$00,$00,$0a,$00,$00,$00,$00,$00,$00,$08,$00,$02,$02,$00,$00
  .byte $00,$00,$0f,$0f,$0f,$0b,$0f,$0b,$0f,$0f,$0f,$0f,$0f,$0f,$0f,$0f,$0f,$0b,$0f,$0f,$0f,$0b,$0f,$0b,$0f,$0f,$0f,$0b,$0f,$0f,$0f,$0f,$0f,$0f,$0b,$0f,$0f,$0e,$00,$00
  .byte $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00




translatechar:
  cmp #'.'
  beq .dot
  cmp #','
  beq .comma
  cmp #'='
  beq .equals
  cmp #' '
  beq .space
  lda #%11001
  rts
.dot
  lda #%00100
  rts
.comma
  lda #%00000
  rts
.equals
  lda #%10110
  rts
.space
  lda #%00010
  rts


draw_image:
.address = VRAM_BASE + 6 * VRAM_STRIDE
.destaddr = $0
.srcaddr = $2
.linesleft = $4
  lda #<.address
  sta .destaddr
  lda #>.address
  sta .destaddr+1
  lda #<imagedata
  sta .srcaddr
  lda #>imagedata
  sta .srcaddr+1

  ldx #36
  stx .linesleft
.loop:

  ldx #13
.loop2

  ldy #39
.loop3

  lda (.srcaddr),y
  jsr translatechar
  ora #BITS_DEFAULT
  sta (.destaddr),y
  dey
  bpl .loop3

  clc
  lda .destaddr
  adc #<VRAM_STRIDE
  sta .destaddr
  lda .destaddr+1
  adc #>VRAM_STRIDE
  sta .destaddr+1

  dex
  bne .loop2

  clc
  lda .srcaddr
  adc #40
  sta .srcaddr
  lda .srcaddr+1
  adc #0
  sta .srcaddr+1

  dec .linesleft
  bne .loop

  rts


draw_image_bw:
.address = VRAM_BASE
.destaddr = $0
.srcaddr = $2
.linesleft = $4
  lda #<.address
  sta .destaddr
  lda #>.address
  sta .destaddr+1
  lda #<imagedatabw
  sta .srcaddr
  lda #>imagedatabw
  sta .srcaddr+1

  ldx #100
  stx .linesleft
.loop:

  ldx #1
.loop2

  ldy #39
.loop3

  lda (.srcaddr),y
  ora #BITS_DEFAULT
  sta (.destaddr),y
  dey
  bpl .loop3

  clc
  lda .destaddr
  adc #<VRAM_STRIDE
  sta .destaddr
  lda .destaddr+1
  adc #>VRAM_STRIDE
  sta .destaddr+1

  dex
  bne .loop2

  clc
  lda .srcaddr
  adc #40
  sta .srcaddr
  lda .srcaddr+1
  adc #0
  sta .srcaddr+1

  dec .linesleft
  bne .loop

  rts


draw_image_320100:
.address = VRAM_BASE
.destaddr = $0
.srcaddr = $2
.linesleft = $4
.width = 160
.height = 100

  lda #<.address
  sta .destaddr
  lda #>.address
  sta .destaddr+1
  lda #<imagedata_320100
  sta .srcaddr
  lda #>imagedata_320100
  sta .srcaddr+1

  lda #0
  sta PORTB

  ldx #.height
  stx .linesleft
.loop:

  ldy #0
.loop3

  lda (.srcaddr),y
  and #BITS_PIXELDATA
  ora #BITS_DEFAULT
  sta (.destaddr),y
  iny
  cpy #.width
  bne .loop3

  clc
  lda .destaddr
  adc #<VRAM_STRIDE
  sta .destaddr
  lda .destaddr+1
  adc #>VRAM_STRIDE
  sta .destaddr+1

  clc
  lda .srcaddr
  adc #.width
  sta .srcaddr
  lda .srcaddr+1
  adc #0
  sta .srcaddr+1

  dec .linesleft
  bne .loop

  rts


draw_black_mark:
.address = VRAM_BASE + 10 * VRAM_STRIDE + 10
  lda #BIT_RESET | BIT_VSYNC | BIT_HSYNC
  sta .address
  sta .address + VRAM_STRIDE
  sta .address + 2*VRAM_STRIDE
  sta .address + 3*VRAM_STRIDE
  rts


  .org $fffc
  .word reset
  .word $0000
