F.loading = (fn)->>
    S.loading = true
    ok = undefined
    err = undefined
    try
        ok := if typeof fn == "function"
            await fn!
        else await fn
    catch
        F.le e
        err := e
    finally
        S.loading = false
        return [ok, err]
