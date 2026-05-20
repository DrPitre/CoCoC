RFILES1 = lib.c/cstuff.lib lib.a/main.lib
RFILE_F	= fmath/cfloats.lib
RFILE_T	= tmath/trans.lib
RFILES2	= imath/math.lib sys.a/syslib.lib

all: libc.a libct.a

before-libc:
	cd lib.c; $(MAKE) $(MAKEFLAGS)
	cd lib.a; $(MAKE) $(MAKEFLAGS)
	cd fmath; $(MAKE) $(MAKEFLAGS)
	cd imath; $(MAKE) $(MAKEFLAGS)
	cd sys.a; $(MAKE) $(MAKEFLAGS)
	cd sys.a; $(MAKE) $(MAKEFLAGS) cstart.o

before-libct:
	cd tmath; $(MAKE) $(MAKEFLAGS)

clean:
	cd lib.c; $(MAKE) $(MAKEFLAGS) clean
	cd lib.a; $(MAKE) $(MAKEFLAGS) clean
	cd fmath; $(MAKE) $(MAKEFLAGS) clean
	cd imath; $(MAKE) $(MAKEFLAGS) clean
	cd tmath; $(MAKE) $(MAKEFLAGS) clean
	cd sys.a; $(MAKE) $(MAKEFLAGS) clean
	rm -f libc.a libct.a

libc.a: before-libc $(RFILES1) $(RFILE_F) $(RFILES2)
	rm -f libc.a
	lwar -cm libc.a $(RFILES1) $(RFILE_F) $(RFILES2)

libct.a: before-libct $(RFILES1) $(RFILE_T) $(RFILES2) before-libct
	rm -f libct.a
	lwar -cm libct.a $(RFILES1) $(RFILE_T) $(RFILES2)

install: libc.a libct.a
	install -m 0644 libc.a libct.a $(LIB)
	install -m 0644 sys.a/cstart.o $(LIB)

.PHONY: dummy before-libc before-libct
