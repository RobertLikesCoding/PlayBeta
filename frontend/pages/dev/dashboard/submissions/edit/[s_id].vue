<template>
  <div class="flex flex-col">
    <SubmissionForm
      mode="edit"
      :submission="data ?? undefined"
      @submission-updated="refreshSubmission"
    />
  </div>
</template>

<script setup lang="ts">
  import SubmissionForm from '~/components/SubmissionForm.vue'

  definePageMeta({
    layout: 'dashboard-developer',
  })

  const route = useRoute()
  const s_id = route.params.s_id as string

  const {
    data,
    pending,
    error,
    refresh: refreshSubmission,
  } = await useSubmission(s_id)
</script>
