{
    line = $0
    tmp = line
    sub(/^[ \t]*/, "", tmp)

    if (tmp ~ /^_[a-z][A-Za-z0-9$_]*:/) {
        alias = tmp
        sub(/^_/, "", alias)
        sub(/:.*/, ":", alias)
        print alias
        print line
        next
    }

    print

    if (tmp ~ /^_[a-z][A-Za-z0-9$_]*[ \t]+EXPORT([ \t].*)?$/) {
        alias = tmp
        sub(/^_/, "", alias)
        print alias
        next
    }

    if (tmp ~ /^_[a-z][A-Za-z0-9$_]*[ \t]*(;.*)?$/) {
        alias = tmp
        sub(/^_/, "", alias)
        print alias
    }
}
