<template>
  <div class="flex flex-col gap-5">
    <UButton
      icon="i-lucide-arrow-left"
      size="xl"
      variant="outline"
      color="neutral"
      class="w-fit"
      to="/dashboard/submissions"
      >Back</UButton
    >
    <LoadingSpinner v-if="isLoading" />

    <div v-else>
      <div class="flex justify-between items-center">
        <h1 class="text-3xl font-bold">{{ data?.title }}</h1>

        <UButton
          label="Edit Submission"
          :href="`/dashboard/submissions/edit/${s_id}`"
        />
      </div>

      <section class="flex flex-col gap-2">
        <p>Created at: {{ data?.created_at }}</p>
        <p>{{ data?.version }}</p>
        <i>{{ data?.description }}</i>
      </section>
    </div>
  </div>
</template>
<script setup lang="ts">
  import LoadingSpinner from '~/components/common/LoadingSpinner.vue'

  const route = useRoute()
  const s_id = route.params.s_id as string

  const { data, pending: isLoading, error } = useSubmission(s_id)
</script>
