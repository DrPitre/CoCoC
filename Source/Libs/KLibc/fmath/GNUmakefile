OFILES = cfloats.o

all: cfloats.lib

include ../cmoc.make

cfloats.lib: $(OFILES)
	lwar -c $@ $^

clean:
	rm -f cfloats.lib $(OFILES) *.s

$(OFILES): GNUmakefile ../cmoc.make $(RMA2LW)
