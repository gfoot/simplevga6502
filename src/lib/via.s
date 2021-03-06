VIA_BASE = $6000
VIA_PORTB = VIA_BASE + 0
VIA_PORTA = VIA_BASE + 1
VIA_DDRB  = VIA_BASE + 2
VIA_DDRA  = VIA_BASE + 3
VIA_T1CL  = VIA_BASE + 4
VIA_T1CH  = VIA_BASE + 5
VIA_T1LL  = VIA_BASE + 6
VIA_T1LH  = VIA_BASE + 7
VIA_T2CL  = VIA_BASE + 8
VIA_T2CH  = VIA_BASE + 9
VIA_SR    = VIA_BASE + 10
VIA_ACR   = VIA_BASE + 11
VIA_PCR   = VIA_BASE + 12
VIA_IFR   = VIA_BASE + 13
VIA_IER   = VIA_BASE + 14
VIA_PAX   = VIA_BASE + 15

VIA_INT_CA2 = $00000001
VIA_INT_CA1 = %00000010
VIA_INT_SR  = %00000100
VIA_INT_CB2 = %00001000
VIA_INT_CB1 = %00010000
VIA_INT_T2  = %00100000
VIA_INT_T1  = %01000000
VIA_INT_SET = %10000000
VIA_INT_CLEAR = 0

PORTB = $6000
PORTA = $6001
DDRB = $6002
DDRA = $6003


via_init
  lda #%11111111 ; Set all pins on port B to output
  sta DDRB
  lda #%11100000 ; Set top 3 pins on port A to output
  sta DDRA

  lda #VIA_INT_SET | VIA_INT_CA1
  sta VIA_IER
  
  lda #1
  sta VIA_PCR

  rts

