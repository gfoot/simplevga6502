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

  jsr load_image_file

  jsr printimm
  .asciiz "B"

  jsr lcd_clear
  jsr printimm
  .asciiz "VGA Sprites!"

  jsr sprite_init
  jsr sprite_update

sprite_loop
  jsr wait_vsync
  jsr sprite_update
  jsr sprite_move
  
  jmp sprite_loop


zp_sprite_base = $70

zp_sprite_x_lo = zp_sprite_base
zp_sprite_x_hi = zp_sprite_base+1
zp_sprite_y_lo = zp_sprite_base+2
zp_sprite_y_hi = zp_sprite_base+3
zp_sprite_x_vel = zp_sprite_base+4
zp_sprite_y_vel = zp_sprite_base+5
zp_sprite_frame = zp_sprite_base+6
zp_sprite_temp = zp_sprite_base+7

SPRITE_X_MIN = VGA_H_BPORCH
SPRITE_X_MAX = VGA_H_BPORCH+VGA_H_VISIBLE-255
SPRITE_Y_MIN = VGA_V_BPORCH
SPRITE_Y_MAX = VGA_V_BPORCH+VGA_V_VISIBLE-255

sprite_init:
  lda #>((SPRITE_X_MIN+SPRITE_X_MAX)/2)
  sta zp_sprite_x_hi
  lda #<((SPRITE_X_MIN+SPRITE_X_MAX)/2)
  sta zp_sprite_x_lo
  lda #4
  sta zp_sprite_x_vel

  lda #>(SPRITE_Y_MIN+4)
  sta zp_sprite_y_hi
  lda #<(SPRITE_Y_MIN+4)
  sta zp_sprite_y_lo
  lda #0
  sta zp_sprite_y_vel

  rts

sprite_update:
  ; Enable port B write handshakes
  lda VIA_PCR
  and #$1f
  ora #$a0
  sta VIA_PCR

  lda zp_sprite_x_lo
  eor #$ff               ; invert all bits
  sta PORTB

  lda zp_sprite_y_lo
  eor #$ff               ; invert all bits
  sta PORTB

  ; Combine the frame number (4 bits) with the x and y high bytes (2 bits each)
  lda zp_sprite_frame
  and #$f
  asl
  asl
  sta zp_sprite_temp

  lda #2                 ; we want the counter to reach 15<<8 at the point the sprite becomes visible, 
  sec                    ; so that the terminal count goes active at that point; and it wraps to zero 
  sbc zp_sprite_x_hi     ; 256 pixels later.  This is just the lower two bits of the counter.  So we 
  and #3                 ; map 0 to 2, 1 to 1, and 2 to 0.  3 kind of maps to itself, meaning -1, and
  ora zp_sprite_temp     ; would be overlapping the edge of the screen.
  asl
  asl
  sta zp_sprite_temp

  lda #2                 ; As above but for Y - map 2 to 0, 1 to 1, 0 to 2, 3 to 3
  sec
  sbc zp_sprite_y_hi
  and #3
  ora zp_sprite_temp

  sta PORTB

  ; Disable port B write handshakes
  lda VIA_PCR
  and #$1f
  sta VIA_PCR

  rts

sprite_move:

  ldy #0
  lda zp_sprite_x_vel
  bpl .movingright

  dec zp_sprite_frame
  dey
  jmp .aftermovingright

.movingright
  inc zp_sprite_frame
.aftermovingright

  clc
  adc zp_sprite_x_lo
  sta zp_sprite_x_lo
  tya
  adc zp_sprite_x_hi
  sta zp_sprite_x_hi
  
  cmp #>SPRITE_X_MAX
  bcc .check_x_min_bounce ; high byte is lower than max - no bounce
  bne .x_bounce           ; high byte is greater than max - bounce
  lda zp_sprite_x_lo
  cmp #<SPRITE_X_MAX
  bcs .x_bounce           ; low byte is higher than max - bounce

.check_x_min_bounce
  lda zp_sprite_x_hi
  cmp #>SPRITE_X_MIN
  bcc .x_bounce           ; high byte is lower than min - bounce
  bne .x_bounce_done      ; high byte is greater than min - no bounce
  lda zp_sprite_x_lo
  cmp #<SPRITE_X_MIN
  bcs .x_bounce_done      ; low byte is higher than min - no bounce

.x_bounce
  sec
  lda #0
  sbc zp_sprite_x_vel
  sta zp_sprite_x_vel
.x_bounce_done
  
  inc zp_sprite_y_vel

  ldy #0
  lda zp_sprite_y_vel
  bpl .movingdown
  dey
.movingdown

  clc
  adc zp_sprite_y_lo
  sta zp_sprite_y_lo
  tya
  adc zp_sprite_y_hi
  sta zp_sprite_y_hi

  cmp #>SPRITE_Y_MAX
  bcc .check_y_min_bounce ; high byte is lower than max - no bounce
  bne .y_bounce           ; high byte is greater than max - bounce
  lda zp_sprite_y_lo
  cmp #<SPRITE_Y_MAX
  bcs .y_bounce           ; low byte is higher than max - bounce

.check_y_min_bounce
  lda zp_sprite_y_hi
  cmp #>SPRITE_Y_MIN
  bcc .y_bounce           ; high byte is lower than min - bounce
  bne .y_bounce_done      ; high byte is greater than min - no bounce
  lda zp_sprite_y_lo
  cmp #<SPRITE_Y_MIN
  bcs .y_bounce_done      ; low byte is higher than min - no bounce

.y_bounce
  clc       ; subtract an extra one to preserve energy
  lda #0
  sbc zp_sprite_y_vel
  sta zp_sprite_y_vel
.y_bounce_done

  rts





  lda zp_sprite_x_lo
  adc zp_sprite_x_vel
  sta zp_sprite_x_lo
  

  jsr wait_button

  jsr printimm
  .asciiz "B"

.Y = $10
.X = $12

  ; First pass - fill control data and red channel (with Y low bits)
  lda #<480
  sta .Y
  lda #>480
  sta .Y+1
.yloop_pass1
  dec .Y

  lda .Y+1
  ora #8
  tay
  lda .Y
  jsr vram_openline

  ldy #160
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

  lda #<480
  sta .Y
  lda #>480
  sta .Y+1
.yloop_pass2
  dec .Y

  lda .Y+1
  ora #4
  tay
  lda .Y
  jsr vram_openline

  lda .Y

  ldy #160
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

  jsr load_image_file

  jsr wait_button

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
  

wait_vsync:
  lda PORTA
  and #1
  beq wait_vsync
.loop
  lda PORTA
  and #1
  bne .loop
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


filename
  .asciiz "IMGFINCHDAT"

load_image_file
  jsr sd_init
  jsr fat32_init
  bcc .initsuccess
 
  ; Error during FAT32 initialization
  lda #'Z'
  jsr print_char
  lda fat32_errorstage
  jsr print_hex
  jmp loop

.initsuccess

  ; Open root directory
  jsr fat32_openroot

  ; Find file by name
  ldx #<filename
  ldy #>filename
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

  lda #<480
  sta .Y
  lda #>480
  sta .Y+1
.yloop_pass2
  dec .Y

  lda .Y+1
  ora #4
  tay
  lda .Y
  jsr vram_openline

  ldy #160
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
  lda #<480
  sta .Y
  lda #>480
  sta .Y+1
.yloop_pass1
  dec .Y

  lda .Y+1
  ora #8
  tay
  lda .Y
  jsr vram_openline

  ldy #160
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
