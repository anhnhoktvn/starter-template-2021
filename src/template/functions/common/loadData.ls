F.loadData = ->
    data = JSON.parse localStorage.getItem C.NAME
    data = data || {}
    for k,v of data
        C.Vue.set S, k, v
