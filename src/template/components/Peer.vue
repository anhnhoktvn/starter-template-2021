<template lang="pug">
span
    slot(:peer="peer" v-if="state === 'OPEN'")
    slot(:peer="peer" name="connecting" v-if="state === 'CONNECTING'")
    slot(:peer="peer" name="open" v-if="state === 'OPEN'")
    slot(:peer="peer" name="close" v-if="state === 'CLOSE'")
</template>
<script lang="ls">
Peer = require('simple-peer')

export default _ =
    props: 
        options: Object
    data: ->
        state: ''
        peer: null
    created: ->
        @connect!
    beforeDestroy: ->
        unless @state == 'CLOSE'
            @peer?.destroy!
    methods:
        connect: ->
            @peer = new Peer @options
            events = [ \signal \connect \data \stream \track \close \error ]
            for let i in events
                @peer.on i, ~> 
                    F.l \on i, it
                    if i == \connect
                        @state = \OPEN
                    else if i == \close
                        @state = \CLOSE

                    @$emit i, it, @peer
            @state = \CONNECTING
            @$emit \init, @peer

</script>
