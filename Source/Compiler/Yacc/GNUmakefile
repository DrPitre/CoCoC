CC=clang
CFLAGS=-std=gnu89 -O -g -DWORD32 -DPARSER=\"$(CURDIR)/yaccpar\" \
	-Wno-implicit-int -Wno-implicit-function-declaration \
	-Wno-deprecated-non-prototype -Wno-int-conversion \
	-Wno-return-mismatch -Wno-format
head: yacc
yacc: y1.o y2.o y3.o y4.o
	$(CC) $(CFLAGS) -o yacc y?.o
y1.o y2.o y3.o y4.o: dextern.h files.h GNUmakefile

install:
	install -s yacc $(DESTDIR)/usr/local/bin
	install -c yaccpar $(DESTDIR)/usr/local/share/yacc
clean :
	rm -f *.o
