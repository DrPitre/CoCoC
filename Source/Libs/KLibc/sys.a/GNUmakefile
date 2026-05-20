OFILES1 = abort.o signal.o chown.o chmod.o stat.o access.o create.o
OFILES2 = open.o read.o write.o io.o misc.o mod.o dir.o brk.o ibrk.o sbrk.o mem.o
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
