function symbol_char(ch) {
    return ch ~ /^[A-Za-z0-9$_]$/
}

function symbol_start(ch) {
    return ch ~ /^[A-Za-z_]$/
}

function dcc_symbol(line) {
    gsub(/__iob/, "_iob", line)
    gsub(/_fpmp/, "fpmp", line)
    gsub(/_buf1/, "buf1", line)
    gsub(/_dectbl/, "dectbl", line)
    return line
}

function asmline(line) {
    print "@" dcc_symbol(line)
}

BEGIN {
    pending_asm_function = 0
    in_asm_function = 0
    in_asm_block = 0
    asm_brace_depth = 0
    function_brace_depth = 0
}

/^[ \t]*(__norts__[ \t]+asm|asm[ \t]+__norts__)[ \t]+/ {
    pending_asm_function = 1
    next
}

pending_asm_function {
    if ($0 ~ /^[ \t]*[A-Za-z_][A-Za-z0-9$_]*[ \t]*\(/) {
        name = $0
        sub(/^[ \t]*/, "", name)
        sub(/[ \t]*\(.*/, "", name)
        asmline("_" name " EXPORT")
        asmline(name " EXPORT")
        asmline("_" name ":")
        asmline(name ":")
        pending_asm_function = 0
        in_asm_function = 1
        function_brace_depth = 0
        next
    }
}

in_asm_function {
    if (!in_asm_block) {
        if ($0 ~ /^[ \t]*asm[ \t]*$/ || $0 ~ /^[ \t]*asm[ \t]*\{/) {
            in_asm_block = 1
            asm_brace_depth = 0
            if ($0 ~ /\{/) {
                asm_brace_depth = 1
            }
        } else if ($0 ~ /\{/) {
            function_brace_depth++
        } else if ($0 ~ /\}/) {
            if (function_brace_depth == 0) {
                in_asm_function = 0
            } else {
                function_brace_depth--
            }
        }
        next
    }

    if ($0 ~ /^[ \t]*\{[ \t]*$/) {
        asm_brace_depth++
        next
    }

    if ($0 ~ /^[ \t]*\}[ \t]*$/) {
        asm_brace_depth--
        if (asm_brace_depth <= 0) {
            in_asm_block = 0
        }
        next
    }

    asmline($0)
    next
}

{
    print
}
