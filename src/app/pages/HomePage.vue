<template lang="pug">
.absolute.inset-0.flex-column
    peer(
        :options="{initiator}" 
        @signal="sendSignal"
        @init="S.peer = $event"
        v-if="showPeer")
        template(slot="open")
            span open
        template(slot="close")
            span close
        template(slot="connecting")
            span connecting
    ws.flex-column.flex-1(:url="C.WS_SERVER_URL" @error="F.l" @close="F.l") 
        // open
        template(v-slot="{ws}")
            dummy(@hook:mounted="init(ws)")
            Login(v-if="!S.session")

            //- main
            .flex-row.flex-1(v-else)
                // contact
                .flex-column.w-1-3.border-r.-pr-px
                    input.p-1.border(v-model.trim="contactSearch" :placeholder="$t('contact')")
                // user list
                .flex-column.w-1-3.border-r.-pr-px
                    dummy(@hook:mounted="init(ws)")
                    SimpleList.flex-1.bg-white
                        // account item
                        SimpleListItem.flex-row.items-center.cursor-pointer.p-1(@click.native="onActiveSession()")
                            span Main
                        SimpleListItem.flex-row.items-center.cursor-pointer.p-1(v-for="i in sessions" @click.native="onActiveSession(i)")
                            .flex-column.flex-1
                                //- span {{i.id}}
                                span {{i.account.username}}
                                span {{i.status}}
                            AButton(@click="offerCall(i.id)" v-if="i.account.id != S.session.account.id")
                                i.fa.fa-phone

                .flex-column.flex-1
                    // header
                    .flex-row.bg-gray-400.p-1.text-lg.font-semibol(v-if="activeSession")
                        //- span {{activeSession.id}}
                        span {{activeSession.account.username}}
                        span {{activeSession.status}}
                        .flex-1
                        .flex-column
                            AButton
                                i.fa.fa-phone
                    SimpleList.flex-1.bg-white
                        SimpleListItem.flex-column.p-1(v-for="i in messages") 
                            //- span {{i}}
                            .flex-row.items-center
                                span.font-bold {{i.from.username}}
                                span.italic.text-sm.ml-2.text-gray-700 {{F.datetimeFormat(i.createdAt)}}
                            span {{i.message}}
                    .flex-row.items-center
                        textarea.flex-1.p-1.border(:placeholder="$t('note')" v-model.trim="message" @keyup.enter.prevent.stop="sendMessage")
                        AButton.h-full(@click="sendMessage")
                            i.fa.fa-send
        span(slot="connecting") connecting
        span(slot="close") closed

</template>
<script lang="ls">
export default _ =
    data: ->
        initiator: false
        contactSearch: ''
        sessions: []
        activeSession: null
        message: ''
        messages: []
        showPeer: false
    mounted: ->
    methods:
        sendSignal: ->
            F.l \signal it
            S.ws.request \signal it
        onActiveSession: (session)->
            @activeSession = session
            if @activeSession
                @getMessages!
            else
                @getGeneralMessages!
        getOnlineAccounts: (ws)->> 
            F.l \wszz
            F.l \ws ws.data.accounts
        init: (ws)->>
            S.ws = ws
            @getGeneralMessages!

            ws.on_signal = (data)~>>
                S.peer?.signal data
            ws.on_invite = (id, initiator)~>>
                @initiator = initiator
                @showPeer = true
                if !initiator
                    await @$nextTick!
                    S.ws.request \accept
            ws.on_offline = (data)~>
                F.l \session data, @sessions
                @sessions = @sessions.filter -> it.id != data.id
            ws.on_online = (data)~>
                @sessions.unshift data
            ws.on_message = (data)~>
                F.l \on_message data
                if (@activeSession?.account.id == data.fromId) or (!@activeSession and !data.toId)
                    @messages.unshift data

            @sessions = await F.request2 \getSessions
        offerCall: (sessionId)->>
            F.request2 \offerCall sessionId
        getLogs: ->
            @logs = []
            @logs = await F.request2 \getLogs S.session.account.id, @activeSession.id
        getGeneralMessages: ->
            F.loading ~>>
                @messages = []
                @messages = await F.request2 \getGeneralMessages 
        getMessages: ->
            F.loading ~>>
                @messages = []
                @messages = await F.request2 \getMessagesFrom S.session.account.id, @activeSession?.account.id
        sendMessage: ->
            return unless @message
            data = 
                fromId: S.session.account.id
                toId: @activeSession?.account.id
                message: @message
            ok = await F.request2 \sendMessage data
            F.l \ok
            @message = ''
            @messages.unshift ok
</script>
