<template>
  <UButton
    v-bind="$attrs"
    icon="i-lucide-arrow-left"
    size="xl"
    variant="outline"
    color="neutral"
    class="w-fit"
    >Back</UButton
  >
</template>

<script setup lang="ts">
  defineOptions({ inheritAttrs: true })
</script>
