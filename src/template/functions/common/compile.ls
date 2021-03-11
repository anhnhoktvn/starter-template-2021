F.compile = ->
    require! {
      livescript: lsc
    }
    lsc.compile it, {-header, -warn, +bare}
