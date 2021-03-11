############### default #################
window.S = Object.assign S, {

    rememberPassword: true
    login:
        username: ''
        password: ''

    loading: false

    session: null
    wsReady: false
    lang: 'vi'
    
}

S.wkeys = [
    \login \rememberPassword \lang
]

############### custom #################
/*
window.S = Object.assign S, do
    time: null
