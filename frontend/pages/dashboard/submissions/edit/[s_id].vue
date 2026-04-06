<template>
  <SubmissionForm
    mode="edit"
    :submission="data"
  />
</template>

<script setup lang="ts">
  import SubmissionForm from '~/components/SubmissionForm.vue'

  definePageMeta({
    layout: 'dashboard',
  })

  const route = useRoute()
  const s_id = route.params.s_id as string

  const { data, pending, error } = await useSubmission(s_id)
</script>
