{
    line = $0
    tmp = line
    sub(/^[ \t]*/, "", tmp)

    if (tmp ~ /^[A-Za-z_][A-Za-z0-9$_]*:[ \t]*(;.*)?$/) {
        label = tmp
        sub(/:.*/, "", label)
        if (seen_label[label]++) next
    }

    if (tmp ~ /^[A-Za-z_][A-Za-z0-9$_]*[ \t]*(;.*)?$/) {
        label = tmp
        sub(/[ \t;].*/, "", label)
        if (seen_label[label]++) next
    }

    if (tmp ~ /^[A-Za-z_][A-Za-z0-9$_]*[ \t]+EXPORT([ \t].*)?$/) {
        symbol = tmp
        sub(/[ \t]+EXPORT.*/, "", symbol)
        if (seen_export[symbol]++) next
    }

    print line
}
