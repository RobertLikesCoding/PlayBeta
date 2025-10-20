<template>
  <div>
    <h2 class="text-2xl mb-3">Your Submissions</h2>

    <NuxtLink to="submissions/new/">
      <UButton icon="i-lucide-plus">Create Submission</UButton>
    </NuxtLink>
  </div>
</template>

<script setup lang="ts">
  import { UButton } from '#components'

  definePageMeta({
    layout: 'dashboard',
  })
</script>
