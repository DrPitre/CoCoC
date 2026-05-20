OFILES1 = swab.o pwcryp.o bsearch.o qsort.o dirutil.o errmsg.o prgname.o \
          datmods.o devtyp.o skip.o sets.o pflinit.o
OFILES2 = fopen.o puts.o gets.o mktemp.o fread.o fwrite.o printf.o
OFILES3 = setbuf.o fseek.o putc.o ftelldummy.o getc.o flshdummy.o setbase.o \
          findstr.o pfldummy.o pffdummy.o htoi.o htol.o ltoa.o xtoa.o
OFILES4 = system.o reverse.o strings.o strcmp.o strlen.o strncpy.o strncat.o \
          strncmp.o strhcpy.o strtok.o strpbrk.o strspn.o index.o patmatch.o
OFILES5 = stringsu.o strucmp.o strnucmp.o case.o strclr.o memccpy.o memchr.o \
          memcmp.o memcpy.o memset.o atol.o atoi.o iob_data.o chcodes.o
OFILES6 = sleep.o setjmp.o strass.o realloc.o calloc.o memory.o rand.o
OFILES7 = gs1.o gs2.o ss.o os_gs_ss.o

OFILES = $(OFILES1) $(OFILES2) $(OFILES3) $(OFILES4) $(OFILES5) \
	$(OFILES6) $(OFILES7)

NFILES = atof.o scale.o ldexp.o frexp.o
DCC_LONG_ABI_OFILES = atol.o fseek.o htol.o ltoa.o

.DEFAULT_GOAL := main.lib

include ../cmoc.make

$(DCC_LONG_ABI_OFILES): %.o: %.a $(RMA2LW) $(TOP)/dcc-long-alias-asm.awk
	$(O2U) < $< | $(SED) -f $(RMA2LW) | awk -f $(TOP)/dcc-long-alias-asm.awk > $*.s
	$(LWASM) $(AFLAGS) --obj -o $@ $*.s
	$(RM) $*.s

printf.o: $(CMOC_OS9_LIB)/printf.c $(TOP)/cmoc-inline-asm-to-dcc.awk
	$(O2U) < $< | awk -f $(TOP)/cmoc-inline-asm-to-dcc.awk > printf.dcc.c
	CDEF=$(DCC_DEFS) $(DCC) -L $(DCCFLAGS) -r -f=$@ printf.dcc.c
	$(RM) printf.dcc.c

main.lib: $(OFILES)
	lwar -c $@ $^

clean:
	-rm main.lib *.o *.s *.cp

$(OFILES): GNUmakefile $(DCCMOC) $(RMA2LW)
