random
.zp_seed = $f0
  sty .zp_seed+5
  ldy #$20
.loop
  lda .zp_seed+2
  lsr
  lsr
  lsr
  eor .zp_seed+4
  ror
  rol .zp_seed
  rol .zp_seed+1
  rol .zp_seed+2
  rol .zp_seed+3
  rol .zp_seed+4
  dey
  bne .loop
  ldy .zp_seed+5
  rts

randomfast
.zp_seed = $f0
  lda .zp_seed
  lsr
  rol .zp_seed+1
  bcc .nc
  eor #$B4
.nc
  sta .zp_seed
  eor .zp_seed+1
  rts

random_range
  sta $0
.loop
  jsr random
  cmp $0
  bcs .loop
  rts
