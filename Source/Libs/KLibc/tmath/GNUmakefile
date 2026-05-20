OFILES = daddsub.o hyp.o dser.o trnser.o trig.o log.o ddiv.o \
	dsqrt.o dtype.o dmul.o dinc.o dcmpr.o

all: trans.lib

include ../cmoc.make

trans.lib: $(OFILES)
	lwar -c $@ $^

clean:
	rm -f trans.lib $(OFILES) *.s

$(OFILES): GNUmakefile ../cmoc.make $(RMA2LW)

daddsub.s hyp.s dser.s trnser.s trig.s log.s ddiv.s dsqrt.s dmul.s dinc.s: mdefs.s
