<template lang="pug">
.flex-column.relative
    .absolute.inset-0.flex-column.overflow-auto
        slot
</template>
<script lang="ls">
export default _ = {}
</script>
<example>
    SimpleList.bg-gray-900.text-white.flex-1
        SimpleListItem.p-1(v-for="i in 100") zz
</example>