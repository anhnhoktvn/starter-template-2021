window.M =
    data: -> S
    created: -> 
        window.S = @
        C.Vue.prototype.S = @
    mounted: ->>
        F.start?!
    computed: {}

