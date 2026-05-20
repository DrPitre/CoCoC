OFILES1 = abort.o signal.o chown.o chmod.o stat.o access.o create.o
OFILES2 = open.o read.o write.o io.o lseek.o misc.o mod.o dir.o brk.o ibrk.o sbrk.o mem.o
OFILES3 = time.o process.o id.o intercept.o syscall.o syscommon.o
OFILES4 = cfinish.o profdummy.o tidyup.o

OFILES = $(OFILES1) $(OFILES2) $(OFILES3) $(OFILES4)

all: syslib.lib cstart.o

include ../cmoc.make

syslib.lib: $(OFILES)
	lwar -c $@ $^

clean:
	rm -f syslib.lib cstart.o root.o *.o *.s

$(OFILES) cstart.o root.o: GNUmakefile ../cmoc.make $(RMA2LW)

cstart.s: cstart-lw.a $(RMA2LW)
	$(O2U) < $< | $(SED) -f $(RMA2LW) > $@

lseek.o: lseek.a $(RMA2LW) $(TOP)/dcc-long-alias-asm.awk
	$(O2U) < $< | $(SED) -f $(RMA2LW) | awk -f $(TOP)/dcc-long-alias-asm.awk > lseek.s
	$(LWASM) $(AFLAGS) --obj -o $@ lseek.s
	$(RM) lseek.s

time.o: time.a $(RMA2LW)
	$(O2U) < $< | $(SED) -f $(RMA2LW) > time.s
	$(LWASM) $(AFLAGS) --obj -o $@ time.s
	$(RM) time.s

io.o: $(CMOC_OS9_LIB)/io.as $(CMOC_RMA2LW) $(DCCMOC) $(CMOC_ALIAS) $(CMOC_DEDUPE) $(TOP)/cmoc-strip-lseek-asm.awk
	$(O2U) < $< | awk -f $(TOP)/cmoc-strip-lseek-asm.awk | $(SED) -f $(CMOC_RMA2LW) | $(SED) -f $(DCCMOC) | awk -f $(CMOC_ALIAS) | awk -f $(CMOC_DEDUPE) > io.s
	$(LWASM) $(AFLAGS) --obj -o $@ io.s
	$(RM) io.s
