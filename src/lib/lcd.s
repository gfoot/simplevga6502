E  = %10000000
RW = %01000000
RS = %00100000

lcd_init:
  lda #%00111000 ; Set 8-bit mode; 2-line display; 5x8 font
  jsr lcd_instruction
  lda #%00001110 ; Display on; cursor on; blink off
  jsr lcd_instruction
  lda #%00000110 ; Increment and shift cursor; don't shift display
  jsr lcd_instruction
  lda #$00000001 ; Clear display
  jsr lcd_instruction

  rts

lcd_wait:
  pha
  lda #%00000000  ; Port B is input
  sta DDRB
lcdbusy:
  lda #RW
  sta PORTA
  lda #(RW | E)
  sta PORTA
  lda PORTB
  and #%10000000
  bne lcdbusy

  lda #RW
  sta PORTA
  lda #%11111111  ; Port B is output
  sta DDRB
  pla
  rts

lcd_instruction:
  jsr lcd_wait
  sta PORTB
  lda #0         ; Clear RS/RW/E bits
  sta PORTA
  lda #E         ; Set E bit to send instruction
  sta PORTA
  lda #0         ; Clear RS/RW/E bits
  sta PORTA
  rts

lcd_clear:
  lda #$00000001 ; Clear display
  jsr lcd_instruction
  rts

lcd_setpos_startline0:
  lda #%10000000
  jmp lcd_instruction

lcd_setpos_startline1:
  lda #%11000000
  jmp lcd_instruction

lcd_setpos_xy:
  txa
  asl
  asl
  cpy #1  ; set carry if Y >= 1
  ror
  sec
  ror
  jmp lcd_instruction

print_char:
  jsr lcd_wait
  sta PORTB
  lda #RS         ; Set RS; Clear RW/E bits
  sta PORTA
  lda #(RS | E)   ; Set E bit to send instruction
  sta PORTA
  lda #RS         ; Clear E bits
  sta PORTA
  rts

print_hex:
  pha
  ror
  ror
  ror
  ror
  jsr print_nybble
  pla
print_nybble:
  and #15
  cmp #10
  bmi .skipletter
  adc #6
.skipletter
  adc #48
  jsr print_char
  rts

printimm:
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

  jsr printmessage

  lda printmessage_bufferptr
  sta $103,x
  lda printmessage_bufferptr+1
  sta $104,x

  pla
  tax
  pla
  rts


printmessage_bufferptr = $80

printmessage:
  pha
  tya
  pha

  ldy #0
.loop:
  lda (printmessage_bufferptr),y
  beq .endloop
  jsr print_char
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
  rts
