F.login = ->> 
    F.loading ->>
        [ok, err] = await F.request \login S.login.username.toLowerCase!, S.login.password
        if err
            F.l \err_login err
            F.showNotification \error, err
        unless ok
            return
        S.session = ok
        if !S.rememberPassword
            S.login.password = ''
