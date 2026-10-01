<template>
  <div class="flex flex-col gap-5">
    <BackButton to="/dev/dashboard/submissions" />
    <LoadingSpinner v-if="isLoading" />

    <div
      v-else
      class="flex flex-col gap-5"
    >
      <div class="flex justify-between items-center">
        <h1 class="text-3xl font-bold">{{ data?.title }}</h1>

        <UButton
          label="Edit Submission"
          :href="`/dev/dashboard/submissions/edit/${s_id}`"
        />
      </div>

      <section class="flex flex-col gap-2">
        <p>Created at: {{ data?.created_at }}</p>
        <i>Description: {{ data?.description }}</i>
        <p>Version: {{ data?.version }}</p>
        <p>Demo URL: {{ data?.demo_url }}</p>
        <p>Genres: {{ submissionGenres }}</p>
        <p>Platforms: {{ submissionPlatforms }}</p>
      </section>
    </div>
  </div>
</template>
<script setup lang="ts">
  import BackButton from '~/components/common/BackButton.vue'
  import LoadingSpinner from '~/components/common/LoadingSpinner.vue'

  const route = useRoute()
  const s_id = route.params.s_id as string

  const { data, pending: isLoading, error } = useSubmission(s_id)

  const submissionGenres = computed(() =>
    data.value?.genres.map((sub) => sub.name).join(', '),
  )
  const submissionPlatforms = computed(() =>
    data.value?.platforms.map((pf) => pf.name).join(', '),
  )
</script>
