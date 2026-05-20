#!/bin/sh
set -eu

ROOT=$(CDPATH= cd -- "$(dirname -- "$0")" && pwd)

PREFIX=${PREFIX:-"$HOME/dcc"}
BINDIR=${BINDIR:-"$PREFIX/bin"}
DCCDIR=${DCCDIR:-"$PREFIX/share/dcc"}
DEFDIR=${DEFDIR:-"$DCCDIR/defs"}
LIBDIR=${LIBDIR:-"$DCCDIR/lib"}
CC=${CC:-clang}
MAKE=${MAKE:-/usr/bin/gnumake}

if [ ! -x "$MAKE" ]; then
	echo "error: GNU make not found at $MAKE" >&2
	echo "Install it with Homebrew, or run with MAKE=/path/to/gmake." >&2
	exit 1
fi

if ! command -v "$CC" >/dev/null 2>&1; then
	echo "error: compiler '$CC' not found on PATH" >&2
	exit 1
fi

if [ "$(uname -s)" != "Darwin" ]; then
	echo "error: this installer is intended for macOS" >&2
	exit 1
fi

run_make() {
	dir=$1
	shift
	( cd "$ROOT/$dir" && "$MAKE" "$@" )
}

install_file() {
	mode=$1
	src=$2
	dst=$3
	install -m "$mode" "$src" "$dst"
}

mkdir -p "$BINDIR" "$DCCDIR" "$DEFDIR" "$LIBDIR"

COMMON_WARN="-Wno-implicit-int -Wno-implicit-function-declaration -Wno-deprecated-non-prototype -Wno-int-conversion -Wno-return-mismatch"

echo "Building dcpp"
run_make Source/Compiler/CPP clean
run_make Source/Compiler/CPP \
	CC="$CC" \
	ARCH= \
	CFLAGS="-std=gnu89 -g -fsigned-char -Dunix -DUNIX -DDCC -DDEBUG -DDEFDIR=\\\"$DEFDIR\\\" -Wall -Wno-incompatible-pointer-types $COMMON_WARN -Wno-parentheses -Wno-return-type -Wno-pointer-to-int-cast" \
	LDFLAGS="-g"

echo "Building dcc68"
run_make Source/Compiler/CC09 clean
run_make Source/Compiler/CC09 \
	CC="$CC" \
	DCCDIR="$DCCDIR" \
	ARCH= \
	CFLAGS="-std=gnu89 -g -fsigned-char -DFUNCNAME -DUNIX -DPTREE -DPROF -DREGCONTS -DCKEYSFILE=\\\"$DCCDIR/ckeys\\\" -Wall -Wno-incompatible-pointer-types $COMMON_WARN -Wno-parentheses -Wno-return-type -Wno-char-subscripts -Wno-format -Wno-pointer-to-int-cast" \
	LDFLAGS="-g -lm"

echo "Building dco68"
run_make Source/Compiler/COpt clean
run_make Source/Compiler/COpt \
	CC="$CC" \
	DCCDIR="$DCCDIR" \
	CFLAGS="-std=gnu11 -g -fsigned-char -DUNIX -DDEBUG -DCONFDIR=\\\"$DCCDIR\\\" -Wall -Wno-char-subscripts -Wno-incompatible-pointer-types $COMMON_WARN -Wno-parentheses -Wno-return-type" \
	LDFLAGS="-g"

echo "Building dcc"
run_make Source/Compiler/DCC clean
run_make Source/Compiler/DCC \
	CC="$CC" \
	CFLAGS="-std=gnu89 -g -fsigned-char -DDCC_DEFDRIVE=\\\"$DCCDIR\\\" -DDCC_LIBDIR=\\\"/lib/\\\" $COMMON_WARN -Wno-incompatible-pointer-types -Wno-return-type" \
	LFLAGS="-g"

echo "Installing binaries into $BINDIR"
install_file 0755 "$ROOT/Source/Compiler/CPP/dcpp" "$BINDIR/dcpp"
install_file 0755 "$ROOT/Source/Compiler/CC09/dcc68" "$BINDIR/dcc68"
install_file 0755 "$ROOT/Source/Compiler/COpt/dco68" "$BINDIR/dco68"
install_file 0755 "$ROOT/Source/Compiler/DCC/dcc" "$BINDIR/dcc"

echo "Installing support files into $DCCDIR"
install_file 0600 "$ROOT/Source/Compiler/CC09/ckeys" "$DCCDIR/ckeys"
install_file 0644 "$ROOT/Source/Compiler/COpt/level1.patterns" "$DCCDIR/level1.patterns"
install_file 0644 "$ROOT/Source/Compiler/COpt/level2.patterns" "$DCCDIR/level2.patterns"
install_file 0644 "$ROOT/Source/Compiler/DCC/dcc.hlp" "$DCCDIR/dcc.hlp"

echo "Installing target include files into $DEFDIR"
( cd "$ROOT/Defs" && find . -type d -exec mkdir -p "$DEFDIR/{}" \; )
( cd "$ROOT/Defs" && find . -type f -exec install -m 0644 "{}" "$DEFDIR/{}" \; )

echo "Building LWTOOLS target library files"
( cd "$ROOT/Source/Libs/KLibc" && PATH="$BINDIR:$PATH" "$MAKE" clean )
( cd "$ROOT/Source/Libs/KLibc" && PATH="$BINDIR:$PATH" "$MAKE" )

echo "Installing LWTOOLS target library files into $LIBDIR"
rm -f "$LIBDIR"/cstart.r "$LIBDIR"/clib.l "$LIBDIR"/clibt.l "$LIBDIR"/sys.l "$LIBDIR"/dbg.l "$LIBDIR"/cgfx.l "$LIBDIR"/lexlib.l "$LIBDIR"/malloc.r "$LIBDIR"/libdbg.a "$LIBDIR"/level1.patterns "$LIBDIR"/level2.patterns
install_file 0644 "$ROOT/Source/Libs/KLibc/libc.a" "$LIBDIR/libc.a"
install_file 0644 "$ROOT/Source/Libs/KLibc/libct.a" "$LIBDIR/libct.a"
install_file 0644 "$ROOT/Source/Libs/KLibc/sys.a/cstart.o" "$LIBDIR/cstart.o"

echo
echo "Installed DCC tools:"
echo "  $BINDIR/dcc"
echo "  $BINDIR/dcpp"
echo "  $BINDIR/dcc68"
echo "  $BINDIR/dco68"
echo
echo "Installed DCC support files:"
echo "  $DCCDIR"
echo "  $DEFDIR"
echo "  $LIBDIR"
echo
echo "Make sure this directory is on PATH:"
echo "  export PATH=\"$BINDIR:\$PATH\""
echo
echo "Use 'dcc file.c' to build and link through lwasm/lwlink. Use 'dcc -R file.c' for the legacy RMA/RLINK flow."
echo "Use 'dcc -a file.c' to stop after generated assembly output."
