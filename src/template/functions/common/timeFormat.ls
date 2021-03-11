F.timeFormat = (date)-> 
    d = new Date date
    h = d.getHours!
    m = d.getMinutes!
    s = d.getSeconds!
    hh = h.toString!padStart 2, \0
    mm = m.toString!padStart 2, \0
    ss = s.toString!padStart 2, \0
    "#hh:#mm:#ss"