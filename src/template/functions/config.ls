############## default ##################
``
import Vue from 'vue'
``
pkg = require '../../../package.json'
window.C = Object.assign C, {
    NAME: \app
    VERSION: pkg.version
    IS_DEV: process.env.NODE_ENV != 'production'
}

C.axios = require('axios')
C.Vue = Vue

############## custom ##################
/*
window.C = Object.assign C, do

if C.IS_DEV  and false
    host = \localhost:2348
    Object.assign C, {

    REQUEST_URL: "http://#host/request"

    }
