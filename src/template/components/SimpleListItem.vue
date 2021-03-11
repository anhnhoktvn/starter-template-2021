<template lang="pug">
.flex-shrink-0.border.-mt-px
    slot
</template>
<script lang="ls">
export default _ = {}
</script>
<example>
SimpleList.flex-1
    SimpleListItem(v-for="i in items")
        span {{i}}
</example>