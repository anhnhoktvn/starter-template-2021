<template lang="pug">
span
    slot(:ws="ws" v-if="state === 'OPEN'")
    slot(:ws="ws" name="connecting" v-if="state === 'CONNECTING'")
    slot(:ws="ws" name="open" v-if="state === 'OPEN'")
    slot(:ws="ws" name="close" v-if="state === 'CLOSE'")
</template>
<script lang="ls">
export default _ =
    props: 
        url: String
        reconnect: Boolean
    data: ->
        state: \CONNECTING
        stop: false
        ws: null
    created: ->
        @connect!
    beforeDestroy: ->
        @stop = true
        @ws.close!
    methods:
        connect: ->
            if @ws?.readyState in [0, 1]
                @ws.close!
            @state = \CONNECTING
            ws = new WebSocket @url
            ws.data = {}
            ws.promiseCount = 0
            ws.promise = []

            ws.json = -> ws.send JSON.stringify it if ws.readyState == 1 
            ws.request = (...a)-> 
                id = ws.promiseCount++ % 1e10
                p = F.delayPromise!
                ws.promise[id] = p
                ws.json [\REQUEST, id, ...a]
                p.promise

            @ws = ws

            @ws.onopen = ~> 
                @state = \OPEN
                @$emit \open @ws
            @ws.onclose = ~>
                @state = \CLOSE
                @$emit \close it
                if !@stop and @reconnect
                    setTimeout @reconnect, 3000
            @ws.onmessage = ~>
                @$emit \message it, @ws
                try
                    data = JSON.parse it.data
                    cmd = data.0
                    F.l \ws data
                    switch cmd
                        case \RESPONSE
                            id = data.1
                            msg = data.2
                            if !ws.promise[id]
                                return
                            ws.promise[id]?.resolve msg
                            delete ws.promise[id]
                        case \REQUEST
                            id = data.1
                            cmd2 = data.2
                            F.l \request_F, cmd2
                            method = 'ws_' + cmd2
                            m = F[method]
                            unless m
                                return ws.json [\RESPONSE, id, [, {error: "METHOD_NOT_FOUND:#cmd2"}]]

                            ok = await F.await2 m ...data.slice 3
                            F.l \result ok
                            ws.json [\RESPONSE, id, ok, m] 
                        else
                            m = "on_#{cmd}"
                            ws[m]? ...data.slice 1

            @ws.onerror = ~>
                @$emit \error it, @ws
</script>
