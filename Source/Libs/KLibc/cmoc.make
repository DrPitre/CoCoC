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
CMOC_RMA2LW	= $(TOP)/cmoc-rma2lw.sed
CMOC_ALIAS	= $(TOP)/cmoc-alias-asm.awk
CMOC_DEDUPE	= $(TOP)/cmoc-dedupe-asm.awk

ifeq ($(strip $(CMOC_OS9_DIR)),)
ifneq ($(filter clean dskclean,$(MAKECMDGOALS)),$(MAKECMDGOALS))
$(error CMOC_OS9_DIR must point to the cmoc_os9 tree)
endif
endif

CMOC_OS9_LIB	= $(CMOC_OS9_DIR)/lib
DCC_DEFS	= $(CMOC_OS9_DIR)/include

# implicit rules to compile with DCC/lwasm
%.o: $(CMOC_OS9_LIB)/%.c
	CDEF=$(DCC_DEFS) $(DCC) -L $(DCCFLAGS) -r -f=$@ $<

%.o: $(CMOC_OS9_LIB)/%.as $(CMOC_RMA2LW) $(DCCMOC) $(CMOC_ALIAS) $(CMOC_DEDUPE)
	$(O2U) < $< | $(SED) -f $(CMOC_RMA2LW) | $(SED) -f $(DCCMOC) | awk -f $(CMOC_ALIAS) | awk -f $(CMOC_DEDUPE) > $*.s
	$(LWASM) $(AFLAGS) --obj -o $@ $*.s
	$(RM) $*.s

%.s: %.as $(RMA2LW)
	$(O2U) < $< | $(SED) -f $(RMA2LW) > $@

%.s: %.a $(RMA2LW)
	$(O2U) < $< | $(SED) -f $(RMA2LW) > $@

%.o: %.s
	$(LWASM) $(AFLAGS) --obj -o $@ $<

%.o: %.c
	CDEF=$(DCC_DEFS) $(DCC) -L $(DCCFLAGS) -r -f=$@ $<
