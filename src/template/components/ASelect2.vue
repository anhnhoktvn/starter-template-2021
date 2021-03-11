<template lang="pug">
Multiselect(v-bind="mapProps" @input="onInput")
  template(slot="noResult")
    span
  template(v-for="(_, slot) of $scopedSlots" v-slot:[slot]="scope")
    slot(:name="slot" v-bind="scope")
</template>

<script>
import 'vue-multiselect/dist/vue-multiselect.min.css'
import Multiselect from 'vue-multiselect'
export default {
  components: { Multiselect },
  props: {
    value: {
      default: null,
    },
    searchable: {
      type: Boolean,
      default: true,
    },
    returnKey: {
      type: String,
      default: '',
    },
    multiple: {
      type: Boolean,
      default: false,
    },
    hideSelected: {
      type: Boolean,
      default: false,
    },
    disabled: {
      type: Boolean,
      default: false,
    },
    label: {
      type: String,
      default: '',
    },
    trackBy: {
      type: String,
      default: '',
    },
    placeholder: {
      type: String,
      default: '',
    },
    showLabels: {
      type: Boolean,
      default: false,
    },
    allowEmpty: {
      type: Boolean,
      default: true,
    },
    options: {
      type: Array,
      default: () => [],
    },
  },
  computed: {
    computedValue() {
      if (!this.returnKey) {
        return this.value
      }
      if (this.multiple) {
        return this.options.filter(
          val => this.value.indexOf(val[this.returnKey]) > -1,
        )
      }
      return this.options.find(val => val[this.returnKey] === this.value)
    },
    mapProps() {
      return Object.assign({}, this.$props, { value: this.computedValue })
    },
  },
  methods: {
    onInput(data) {
      const r = !this.returnKey
        ? data
        : this.multiple
        ? data.map(val => val[this.returnKey])
        : data && data[this.returnKey]
      this.$emit('input', r)
    },
  },
}
</script>

<example>
  ASelect2(
    v-model="$root.selectedGroupId"
    :options="$root.groups.concat([{name: $t('all'), id: null}])"
    label="name"
    trackBy="id",
    returnKey="id"
    :placeholder="$t('group')"
  )
</example>
