<script setup lang="ts">
  import BackButton from '~/components/common/BackButton.vue'
</script>

<template>
  <div
    class="min-h-screen w-full flex flex-col gap-5 justify-center items-center"
  >
    <BackButton
      to="/"
      variant="ghost"
    />

    <slot />
  </div>
</template>
