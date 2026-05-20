# disable built-in rules
MAKEFLAGS+=-rR

AFLAGS= --pragma=index0tonone,condundefzero,undefextern,dollarnotlocal,noforwardrefmax --includedir=$(DCC_DEFS)
DCCFLAGS= -q

# default top level to current dir
TOP?=	$(dir $(realpath $(lastword $(MAKEFILE_LIST))))
# our commands
SED?=	sed
DCC?=	dcc
LWASM?=	lwasm
O2U?=	tr '\015' '\012'
#our scripts
DCCMOC	= $(TOP)/dccmoc.sed
RMA2LW	= $(TOP)/rma2lw.sed
DCC_DEFS?= $(TOP)/../../../Defs

# implicit rules to compile with DCC/lwasm
%.s: %.a $(RMA2LW)
	$(O2U) < $< | $(SED) -f $(RMA2LW) > $@

%.o: %.s
	$(LWASM) $(AFLAGS) --obj -o $@ $<

%.o: %.c
	$(DCC) -L $(DCCFLAGS) -r -f=$@ $<
