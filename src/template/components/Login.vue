<template lang="pug">
.w-full.h-full.absolute.bg-gray-800.text-white.flex-column.items-center.justify-center
    .flex-column.w-64
        input.text-black.mb-1.rounded.p-1.border(@keyup.enter="F.login" :placeholder="$t('username')" v-model.trim="S.login.username")
        input.text-black.mb-1.rounded.p-1.border(@keyup.enter="F.login" :placeholder="$t('password')" type="password" v-model="S.login.password")
        label.my-4
            input.mb-1.rounded.p-1.border( type="checkbox" v-model="S.rememberPassword")
            span.ml-2 {{$t('remember_password')}}
        .flex-row.justify-center
            AButton(@click="login") {{$t('login')}}
            AButton(color="green" @click="F.changeLanguage")
                i.fa.fa-language
                span.ml-2 {{$t('lang_' + S.lang)}}
        .flex-row.justify-center.mt-4.text-xs
            span v{{C.VERSION}}
</template>
<script lang="ls">
export default _ =
    methods:
        login: ->>
            F.loading ->>
                [ok, err] = await F.request \login S.login.username.toLowerCase!, S.login.password
                unless ok
                    F.notify err, \error
                    return
                S.session = ok
                if !S.rememberPassword
                    S.login.password = ''

</script>
