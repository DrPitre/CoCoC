BEGIN {
    public["atol"] = 1
    public["fseek"] = 1
    public["rewind"] = 1
    public["ftell"] = 1
    public["htol"] = 1
    public["ltoa"] = 1
    public["lseek"] = 1
}

{
    label = $0
    if (label ~ /^[A-Za-z][A-Za-z0-9$_]*:/) {
        sub(/:.*/, "", label)
        if (public[label]) {
            print "_" label " EXPORT"
            print "_" label ":"
        }
    } else if (label ~ /^[A-Za-z][A-Za-z0-9$_]*[ \t]+EXPORT([ \t].*)?$/) {
        sub(/[ \t]+EXPORT.*/, "", label)
        if (public[label])
            print "_" label " EXPORT"
    } else {
        sub(/[ \t].*/, "", label)
        if (public[label])
            print "_" label
    }
    print
}
