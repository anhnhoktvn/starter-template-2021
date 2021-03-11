F.request = (cmd, ...args)->> 
    #S.ws.request ...
    C.axios.post C.REQUEST_URL, {cmd, args}, {
        headers:
            Authorization: 'Bearer ' + (S.session?.token || '')
    }
        .then (.data)
