# translate cmoc_os9 assembly for lwasm without auto-exporting every label.
# cmoc_os9 sources already declare public symbols explicitly.
s|^[\t ]*use[\t ][\t ]*/dd/defs/\(.*\)| use \1|
s|^[\t ]*use[\t ][\t ]*\.\./include/\(.*\)| use \1|
s|^[\t ]*use[\t ][\t ]*mdefs\.a| use mdefs.s|
s|^[\t ]*use[\t ][\t ]*os9defs\.a| use os9.d|
s/\([A-Za-z]\)\$\([A-Za-z]\)/\1_\2/g
s/^[\t ]*psect.*/ SECTION code/
s/^[\t ]*section[\t ][\t ]*rodata.*/ SECTION code/
s/^[\t ]*vsect.*/ SECTION bss/
s/^[\t ]*csect[\t ][\t ]*\(.*\)/ SECTION _constant\n org \1/
s/^[\t ]*csect/ SECTION _constant/
s/^[\t ]*endsect.*/ ENDSECT\n SECTION code/
s/^[\t ]*ends.*/ ENDSECT\n SECTION code/
s/^[\t ]*fail\(.*\)/ ERROR\1/
s/^[\t ]*warn\(.*\)/ WARNING\1/
