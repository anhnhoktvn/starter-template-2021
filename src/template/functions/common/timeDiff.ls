F.timeDiff = (a, b, type = 'ms', rounded = false)-> 
    ms = +new Date(a) - +new Date(b)
    t = switch type
        case \s
            ms / 1000
        case \m
            ms / 1000 / 60
        case \h
            ms / 1000 / 60 / 60
        default
            ms
    if rounded
        Math.round t
    else
        t