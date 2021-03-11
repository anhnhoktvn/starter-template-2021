F.saveFile = (url, filename = \download)->>
    F.loading ->>
        ok = await C.axios.get url, {
            responseType: 'blob'
        }
        d = window.URL.createObjectURL new Blob [ok.data]
        a = document.createElement \a
        a.href = d
        a.download = filename
        document.body.appendChild(a)
        a.click()
        a.remove()
