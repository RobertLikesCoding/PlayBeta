<template>
  <UTable
    :data="submissions"
    class="flex-1"
    :loading="loadingSubmissions"
  />
</template>

<script setup lang="ts">
  import type { Submission } from '~/types/Submission'

  defineProps<{
    submissions: Submission[] | undefined
    loadingSubmissions: boolean
  }>()
</script>
