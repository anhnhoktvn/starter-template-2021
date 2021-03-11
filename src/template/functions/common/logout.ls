F.logout = ->> 
    [ok, err] = await F.request \logout 
    S.session = null
