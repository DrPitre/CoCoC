s:^#[\t ]*asm:asm { /* #asm */:
s:^#[\t ]*endasm:} /* #endasm */:

# DCC keeps a few KLibc data names unprefixed or single-prefixed where CMOC
# assembly expects CMOC's normal extra underscore.
s/__iob/_iob/g
s/__mtop/_mtop/g
s/__stbot/_stbot/g
s/__dumprof/_dumprof/g
s/__tidyup/_tidyup/g
s/_errno/errno/g
