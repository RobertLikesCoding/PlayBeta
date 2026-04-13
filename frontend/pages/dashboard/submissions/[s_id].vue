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

    <section class="flex">
      <div class="border-2 rounded-2xl p-5">
        <strong>Active Testers</strong>
      </div>
    </section>
  </div>
</template>
<script setup lang="ts">
  const route = useRoute()
  const s_id = route.params.s_id as string

  const { data, pending, error } = await useSubmission(s_id)
</script>
