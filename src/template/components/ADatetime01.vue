<template lang="pug">
FlatPickr.border.bg-white.text-black.p-2(v-bind="$attrs" :config="{...defaultConfig, ...config}" v-on="$listeners")
</template>

<script>
import FlatPickr from 'vue-flatpickr-component'
import 'flatpickr/dist/flatpickr.css'
export default {
  inheritAttrs: false,
  props: {
    config: {
      type: Object,
      default: () => ({}),
    },
  },
  components: {
    FlatPickr,
  },
  data() {
    return {
      defaultConfig: {
        enableTime: true,
        dateFormat: 'Z',
        altInput: true,
        altFormat: 'Y-m-d h:i K',
      },
    }
  },
}
</script>
<example>
ADatetime(v-model="date")
</example>
