``
import Vue from 'vue'
import App from './App.vue'
import './assets/tailwind.css'
import 'font-awesome/css/font-awesome.css'
import InfiniteLoading from 'vue-infinite-loading'
``

window.F = {}
window.S = {}
window.C = {}
window.M = {}
window.I = {}

Vue.use(InfiniteLoading)
Vue.config.productionTip = false

# functions
do ->
    r = require.context './template/functions', true, /\.ls$/
    for i in r.keys!
        r i
do ->
    r = require.context './app/functions', true, /\.ls$/
    for i in r.keys!
        r i
# components
c = (r, i) ->
    config = r i
    name = i.split '/'
            .pop!
            .replace /\.\w+$/, ''
    Vue.component name, config.default || config
do ->
    r = require.context './template/components', true, /\.(vue|ls)$/
    for i in r.keys!
        c r, i
do ->
    r = require.context './app/components', true, /\.(vue|ls)$/
    for i in r.keys!
        c r, i
do ->
    r = require.context './template/pages', true, /\.(vue|ls)$/
    for i in r.keys!
        c r, i
do ->
    r = require.context './app/pages', true, /\.(vue|ls)$/
    for i in r.keys!
        c r, i

Vue.prototype.F = F
Vue.prototype.S = S
Vue.prototype.C = C

new Vue({
    mixins: [M],
    render: (h)-> h(App)
}).$mount('#app')

