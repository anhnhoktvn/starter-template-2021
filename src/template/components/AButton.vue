<template lang="pug">
button.btn.leading-relaxed.font-medium.flex.items-center.cursor-pointer.border.shadow.hover-shadow-lg.focus-outline-none.focus-shadow-outline(:class='btnClasses', v-bind='$attrs' @click="!disabled && $emit('click')")
  slot
</template>
<script>
let colors = {
    "blue_1_1": "border-blue-200 bg-white text-blue-200 hover-bg-blue-200 hover-border-blue-200 hover-text-white",
    "blue_1_0": "bg-blue-200 text-blue-100 border-blue-200  cursor-not-allowed",
    "blue_0_1": "border-blue-600 bg-white text-blue-600 hover-bg-blue-600 hover-border-blue-600 hover-text-white",
    "blue_0_0": "bg-blue-600 text-blue-100 border-blue-600 hover-bg-blue-700 hover-border-blue-700  hover-text-white ",
    "green_1_1": "border-green-200 bg-white text-green-200 hover-bg-green-200 hover-border-green-200 hover-text-white",
    "green_1_0": "bg-green-200 text-green-100 border-green-200  cursor-not-allowed",
    "green_0_1": "border-green-600 bg-white text-green-600 hover-bg-green-600 hover-border-green-600 hover-text-white",
    "green_0_0": "bg-green-600 text-green-100 border-green-600 hover-bg-green-700 hover-border-green-700  hover-text-white ",
    "yellow_1_1": "border-yellow-200 bg-white text-yellow-200 hover-bg-yellow-200 hover-border-yellow-200 hover-text-white",
    "yellow_1_0": "bg-yellow-200 text-yellow-100 border-yellow-200  cursor-not-allowed",
    "yellow_0_1": "border-yellow-600 bg-white text-yellow-600 hover-bg-yellow-600 hover-border-yellow-600 hover-text-white",
    "yellow_0_0": "bg-yellow-600 text-yellow-100 border-yellow-600 hover-bg-yellow-700 hover-border-yellow-700  hover-text-white ",
    "red_1_1": "border-red-200 bg-white text-red-200 hover-bg-red-200 hover-border-red-200 hover-text-white",
    "red_1_0": "bg-red-200 text-red-100 border-red-200  cursor-not-allowed",
    "red_0_1": "border-red-600 bg-white text-red-600 hover-bg-red-600 hover-border-red-600 hover-text-white",
    "red_0_0": "bg-red-600 text-red-100 border-red-600 hover-bg-red-700 hover-border-red-700  hover-text-white "
}
export default {
  inheritAttrs: false,
  props: {
    color: {
      type: String,
      default: 'blue',
    },
    size: {
      type: String,
      default: 'sm', // xs, sm, md, lg
    },
    outline: Boolean,
    disabled: {
      type: Boolean,
      default: false,
    },
    icon: Boolean,
    round: Boolean,
  },
  computed: {
    colorClasses() {
      let disabled = +!!this.disabled
      let outline = +!!this.outline
      let color = this.color
      return colors[color + '_' + disabled + '_' + outline]
    },
    sizeClasses() {
      const isIcon = this.icon
      const sizeMappings = {
        xs: `h-6 text-xs ${isIcon ? 'px-1' : 'px-2'}`,
        sm: `h-8 text-xs ${isIcon ? 'px-2' : 'px-4'}`,
        md: `h-10 ${isIcon ? 'px-3' : 'px-6'}`,
        lg: `text-lg h-12 ${isIcon ? 'px-4' : 'px-12'}`,
      }

      return sizeMappings[this.size] || sizeMappings.md
    },
    btnClasses() {
      const borderRadiusClasses = this.round ? 'rounded-full' : 'rounded'
      return `${this.colorClasses} ${this.sizeClasses} ${borderRadiusClasses}`
    },
  },
}
</script>
#generate code

    colors = [ \blue \green \yellow \red ]
    disableds = [1 0]
    r = {}
    for color in colors
        for disabled in disableds
            deep = if disabled then 200 else 600

            cursorClass = if disabled then 'cursor-not-allowed' else ''
            hoverClasses = if disabled then '' else "hover-bg-#{color}-#{deep + 100} hover-border-#{color}-#{deep + 100}  hover-text-white"
            baseClasses = "bg-#{color}-#{deep} text-#{color}-100 border-#{color}-#{deep} #{hoverClasses} #{cursorClass}"
            outlineClasses = "border-#{color}-#{deep} bg-white text-#{color}-#{deep} hover-bg-#{color}-#{deep} hover-border-#{color}-#{deep} hover-text-white"
            r[color + \_ + disabled + \_ + 1] = outlineClasses
            r[color + \_ + disabled + \_ + 0] = baseClasses
    r
            

