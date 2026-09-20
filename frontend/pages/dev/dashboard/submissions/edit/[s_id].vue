<template>
  <div class="flex flex-col gap-5">
    <UButton
      icon="i-lucide-arrow-left"
      size="xl"
      variant="outline"
      color="neutral"
      class="w-fit"
      to="/dev/dashboard/submissions"
      >Back</UButton
    >

    <SubmissionForm
      mode="edit"
      :submission="data ?? undefined"
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

  const { data, pending, error } = await useSubmission(s_id)
</script>
