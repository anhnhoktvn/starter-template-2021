F.disableBackButton = ->
    history.pushState(null, null, document.URL)
    window.addEventListener 'popstate', -> history.pushState(null, null, document.URL)
