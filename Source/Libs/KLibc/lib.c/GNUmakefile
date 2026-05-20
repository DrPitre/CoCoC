OFILES	= prof.o pwent.o getopt.o adump.o defdrive.o popen.o \
 asctime.o ctime.o systime.o time.o localtime.o mktime.o isleap.o timevars.o

all: cstuff.lib

include ../cmoc.make

CFLAGS += -I../defs

cstuff.lib: $(OFILES)
	lwar -c $@ $^

clean:
	rm -f cstuff.lib dbg.lib *.o *.s *.cp *.list *.map c.errors

$(OFILES): GNUmakefile $(DCCMOC) $(RMA2LW)
