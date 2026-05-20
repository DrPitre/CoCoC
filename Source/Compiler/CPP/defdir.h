/*
	@(#)defdir.h	2.2.1	6/15/87
*/
#ifndef DEFNAME
#define DEFNAME "/dd"
#endif
#ifndef DEVNAME
#define DEVNAME "/d0"
#endif

#ifndef DEFDIR
#if defined(vms)
#	define DEFDIR "Osk$Defs:"
#elif defined(sys5)
#	define DEFDIR "/user/defs"
#else
#	define DEFDIR "/dd/defs"
#endif
#endif
