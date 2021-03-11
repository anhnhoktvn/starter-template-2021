############## custom ##################

host = \localhost:2001
window.C = Object.assign C, do
    # REQUEST_URL: "http://#host/request"
    WS_SERVER_URL: "ws://localhost:2001"

if C.IS_DEV  and false
    host = \localhost:2001
    Object.assign C, {

    # REQUEST_URL: "http://#host/request"

    }
