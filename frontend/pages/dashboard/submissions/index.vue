<template>
  <div>
    <h2 class="text-2xl mb-3">Your Submissions</h2>

    <UButton
      icon="i-lucide-plus"
      to="submissions/new/"
      >Create Submission</UButton
    >
  </div>
</template>

<script setup lang="ts">
  import { UButton } from '#components'

  definePageMeta({
    layout: 'dashboard',
  })
</script>
