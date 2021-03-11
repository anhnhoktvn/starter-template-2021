``
import Vue from 'vue'
``

Vue.prototype.$t = (name) -> I[S.lang][name] || name
F.$t = Vue.prototype.$t
/*
i18n = [
  {
    "key": "voice_title",
    "vi": "Audio phát thanh Minh Huệ. Tải về để gửi",
    "cn": "明慧广播。先下载再发出去"
  },
]

r = 
    vi: {}
    cn: {}
for i in i18n
    r.vi[i.key] = i.vi
    r.cn[i.key] = i.cn
merge = require \deepmerge
window.I = merge window.I, r
