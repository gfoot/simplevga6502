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

filenameptr = $80

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

  jsr wait_button

  jsr printimm
  .asciiz "B"

.Y = $10
.X = $12

  ; First pass - fill control data and red channel (with Y low bits)
  lda #<VRAM_HEIGHT
  sta .Y
  lda #>VRAM_HEIGHT
  sta .Y+1
.yloop_pass1
  dec .Y

  lda .Y+1
  ora #8
  tay
  lda .Y
  jsr vram_openline

  ldy #VRAM_WIDTH
.xloop_pass1
  dey

  tya
  and #BITS_PIXELDATA
  ora #BITS_DEFAULT
  sta (ZP_PTR),y

  cpy #0
  bne .xloop_pass1

  lda .Y
  bne .yloop_pass1
  dec .Y+1
  bpl .yloop_pass1


  ; Second pass - fill remaining channels with Y bits  

  lda #<VRAM_HEIGHT
  sta .Y
  lda #>VRAM_HEIGHT
  sta .Y+1
.yloop_pass2
  dec .Y

  lda .Y+1
  ora #4
  tay
  lda .Y
  jsr vram_openline

  lda .Y

  ldy #VRAM_WIDTH
.xloop_pass2
  dey
  sta (ZP_PTR),y
  bne .xloop_pass2

  lda .Y
  bne .yloop_pass2
  dec .Y+1
  bpl .yloop_pass2


  jsr wait_button

  lda #0
  jsr vram_clear
  jsr wait_button

  jsr fsinit

.imgloadloop

  lda #<filename_finch
  sta filenameptr
  lda #>filename_finch
  sta filenameptr+1
  jsr load_image_file

  jsr wait_button

  lda #<filename_testcard
  sta filenameptr
  lda #>filename_testcard
  sta filenameptr+1
  jsr load_image_file

  jsr wait_button

  jmp .imgloadloop

.randomloop

  ; Y low
  jsr random
  sta .Y

  ; Y high
  jsr random
  ror
  ror
  ror
  and #1
  sta .Y+1

  ; Check in range 0-480
  beq .y_ok
  lda .Y
  cmp #<480
  bcs .randomloop

.y_ok

  ; X/4
  lda #160
  jsr random_range
  sta .X

  ; Colour
  inc $20
  bne .after_colour_increment
  inc $21
.after_colour_increment

  lda .Y+1
  ora #8
  tay
  lda .Y
  jsr vram_openline
  ldy .X

  lda $21
  and #BITS_PIXELDATA
  ora #BITS_DEFAULT
  sta (ZP_PTR),y

  lda .Y+1
  ora #4
  tay
  lda .Y
  jsr vram_openline
  ldy .X

  lda $20
  sta (ZP_PTR),y

  jmp .randomloop
  

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


filename_testcard
  .asciiz "TESTCARDDAT"
filename_finch
  .asciiz "IMGFINCHDAT"

fsinit
  jsr sd_init
  jsr fat32_init
  bcs .error
  rts
.error
  ; Error during FAT32 initialization
  lda #'Z'
  jsr print_char
  lda fat32_errorstage
  jsr print_hex
  jmp loop

load_image_file

  ; Open root directory
  jsr fat32_openroot

  ; Find file by name
  ldx filenameptr
  ldy filenameptr+1
  jsr fat32_finddirent
  bcc .foundfile

  ; File not found
  lda #'Y'
  jsr print_char
  jmp loop

.foundfile
 
  ; Open file
  jsr fat32_opendirent

.Y = $10
.X = $12

  ; Second pass - fill remaining channels with Y bits  

  lda #<VRAM_HEIGHT
  sta .Y
  lda #>VRAM_HEIGHT
  sta .Y+1
.yloop_pass2
  dec .Y

  lda .Y+1
  ora #4
  tay
  lda .Y
  jsr vram_openline

  ldy #VRAM_WIDTH
.xloop_pass2
  sty .X
  jsr fat32_file_readbyte
  ldy .X

  dey
  sta (ZP_PTR),y

  bne .xloop_pass2

  lda .Y
  bne .yloop_pass2
  dec .Y+1
  bpl .yloop_pass2
  

  ; First pass - fill control data and red channel (with Y low bits)
  lda #<VRAM_HEIGHT
  sta .Y
  lda #>VRAM_HEIGHT
  sta .Y+1
.yloop_pass1
  dec .Y

  lda .Y+1
  ora #8
  tay
  lda .Y
  jsr vram_openline

  ldy #VRAM_WIDTH
.xloop_pass1
  sty .X

  jsr fat32_file_readbyte

  and #BITS_PIXELDATA
  ora #BITS_DEFAULT

  ldy .X
  dey
  sta (ZP_PTR),y

  bne .xloop_pass1

  lda .Y
  bne .yloop_pass1
  dec .Y+1
  bpl .yloop_pass1

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
