CC=clang
YACC=../Yacc/yacc
CFLAGS = -std=gnu89 -g -Dunix -DCNAME=\"$(CURDIR)/ncform\" \
	-Wno-implicit-int -Wno-implicit-function-declaration \
	-Wno-deprecated-non-prototype -Wno-int-conversion \
	-Wno-return-mismatch -Wno-incompatible-pointer-types \
	-Wno-format -Wno-pointer-sign

all: lex

lex: lmain.o y.tab.o sub1.o sub2.o header.o
	$(CC) $(CFLAGS) lmain.o y.tab.o sub1.o sub2.o header.o -o lex

smallex:
	$(CC) $(CFLAGS) -DSMALL lmain.c y.tab.c sub1.c sub2.c header.c -o smallex

y.tab.c: parser.y
	$(YACC) parser.y
lmain.o:lmain.c ldefs.c once.c
	$(CC) -c $(CFLAGS) lmain.c
sub1.o: sub1.c ldefs.c
	$(CC) -c $(CFLAGS) sub1.c
sub2.o: sub2.c ldefs.c
	$(CC) -c $(CFLAGS) sub2.c
header.o: header.c ldefs.c
	$(CC) -c $(CFLAGS) header.c

install: all
	install -s lex $(DESTDIR)/usr/local/bin
	install -c ncform $(DESTDIR)/usr/local/share/lex

clean:
	rm -f *.o lex y.tab.c
