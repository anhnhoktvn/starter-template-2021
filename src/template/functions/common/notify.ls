Swal = require('sweetalert2')

F.notify = (title, icon = 'success', other = {})->
    Swal.fire do
        icon: icon
        title: F.$t title
        toast: true,
        position: 'bottom-end',
        showConfirmButton: false,
        showCloseButton: true,
        timer: 3000,
        # timerProgressBar: true,
        # didOpen: (toast) ->
        #     toast.addEventListener('mouseenter', Swal.stopTimer)
        #     toast.addEventListener('mouseleave', Swal.resumeTimer)
        ...other

F.alert = (...a)-> Swal.fire ...a

F.confirm = (title, text)-> 
    Swal.fire do
        icon: \question
        title: F.$t title
        text: F.$t text
        confirmButtonText: F.$t \yes
        denyButtonText: F.$t \no
        showConfirmButton: true
        showDenyButton: true
    .then -> it.isConfirmed