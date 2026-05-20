# translate name: into name EXPORT followed by name
#s/^\([a-zA-Z_][a-zA-Z0-9$_]\+\):/\1 EXPORT\n\1/
s/^\([a-zA-Z_][a-zA-Z0-9$_]*\):/\1 EXPORT\n\1/
# translate sections
s|^[\t ]*use[\t ][\t ]*/dd/defs/\(.*\)| use \1|
s|^[\t ]*use[\t ][\t ]*mdefs\.a| use mdefs.s|
s/^[\t ]*psect.*/ SECTION code/
s/^[\t ]*vsect.*/ SECTION bss/
s/^[\t ]*csect[\t ][\t ]*\(.*\)/ SECTION _constant\n org \1/
s/^[\t ]*csect/ SECTION _constant/
s/^[\t ]*endsect.*/ ENDSECT\n SECTION code/
s/^[\t ]*ends.*/ ENDSECT\n SECTION code/
# convert fail / warn directives
s/^[\t ]*fail\(.*\)/ ERROR\1/
s/^[\t ]*warn\(.*\)/ WARNING\1/
