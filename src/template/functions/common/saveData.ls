F.saveData = ->
    r = {}
    for i in S.wkeys
        r[i] = S[i]
    localStorage.setItem C.NAME, JSON.stringify r
