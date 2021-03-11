#
F.l = -> console.log ...
F.le = -> console.error ...

#
F.la = ->>
    try
        console.log await it
    catch
        console.error e
#
F.delayPromise = -> 
  p = {}
  p.state = 0
  p.promise = new Promise (res,rej) ->
    p.resolve = -> 
      p.state = 1
      res it
    p.reject = ->
      p.state = -1
      rej it
  p

#
F.sleep = (ms) -> new Promise (res) -> setTimeout res, ms


F.random = (start, end) -> 
    if end
        Math.floor(Math.random! * (end - start)) + start
    else
        Math.floor(Math.random! * start)



F.await2 = ->>
    err = void
    try
        r = await it
    catch
        err = e
    [r, err]

F.throw2 = ->>
    [ok, err] = await it
    throw err if err
    ok


F.now = -> new Date!toJSON!
