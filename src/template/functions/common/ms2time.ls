F.ms2time = (ms)->
    s = Math.ceil ms / 1000
    ss = s % 60
    ss = ss.toString!padStart 2, '0'
    m = Math.floor s / 60
    mm = m.toString!padStart 2, '0'
    "#mm:#ss"