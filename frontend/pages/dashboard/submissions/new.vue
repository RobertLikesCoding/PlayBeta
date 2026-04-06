<template>
  <div>
    <div class="flex flex-col gap-4 mb-4">
      <UButton
        icon="i-lucide-arrow-left"
        size="xl"
        variant="outline"
        color="neutral"
        class="w-fit"
        to="/dashboard/submissions"
        >Back</UButton
      >
      <h2 class="text-3xl font-bold">Create a new submission</h2>
    </div>

    <SubmissionForm mode="create" />
  </div>
</template>
<script setup lang="ts">
  import SubmissionForm from '~/components/SubmissionForm.vue'

  definePageMeta({
    layout: 'dashboard',
  })
</script>
