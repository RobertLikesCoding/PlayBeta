<template>
  <section data-test-id="submissions-overview">
    <div class="flex justify-between mb-5">
      <h2 class="text-2xl">Your Submissions</h2>

      <UButton
        icon="i-lucide-plus"
        href="submissions/new/"
        >Create New Submission</UButton
      >
    </div>

    <SubmissionsTable
      :submissions="data"
      :loadingSubmissions="loadingSubmissions"
    />
  </section>
</template>

<script setup lang="ts">
  import { UButton } from '#components'
  import SubmissionsTable from './SubmissionsTable.vue'

  definePageMeta({
    layout: 'dashboard',
  })

  const { data, pending: loadingSubmissions } = useSubmissionsList()
</script>
