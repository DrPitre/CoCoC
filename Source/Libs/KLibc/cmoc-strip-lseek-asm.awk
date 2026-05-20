/_lseek[[:space:]]+EXPORT/ {
    next
}

/^_lseek:/ {
    skip = 1
    next
}

skip && /^[[:space:]]+endsect/ {
    skip = 0
    print
    next
}

skip {
    next
}

{
    print
}
