<template>
  <div class="flex flex-col gap-5">
    <div class="flex justify-between items-center">
      <BackButton to="/dev/dashboard/submissions" />
      <div class="flex gap-2">
        <SubmissionStatusChangeModal
          :submission-status="data?.status!"
          :loading="isStatusChangeLoading"
          @selected-status="handleStatusChange"
        />
        <UButton
          label="Edit Submission"
          :href="`/dev/dashboard/submissions/edit/${s_id}`"
        />
      </div>
    </div>
    <LoadingSpinner v-if="isLoading" />

    <div
      v-else
      class="flex flex-col gap-5"
    >
      <div class="flex justify-between items-center">
        <div class="flex gap-2">
          <h1 class="text-3xl font-bold">{{ data?.title }}</h1>
          <SubmissionStatusBadge :submission-status="data?.status!" />
        </div>
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
  import { UButton } from '#components'
  import BackButton from '~/components/common/BackButton.vue'
  import LoadingSpinner from '~/components/common/LoadingSpinner.vue'
  import type { SubmissionStatus } from '~/types/Submission'

  const route = useRoute()
  const s_id = route.params.s_id as string

  const { data, pending: isLoading, error } = useSubmission(s_id)
  const { saveSubmission, isLoading: isStatusChangeLoading } =
    useSubmissionSave()

  const submissionGenres = computed(() =>
    data.value?.genres.map((genre) => genre.name).join(', '),
  )
  const submissionPlatforms = computed(() =>
    data.value?.platforms.map((pf) => pf.name).join(', '),
  )

  async function handleStatusChange(selectedStatus: SubmissionStatus) {
    const payload = {
      submission: { status: selectedStatus },
    }
    await saveSubmission({
      method: 'PATCH',
      requestPath: `/api/v1/submissions/${s_id}`,
      payload: payload,
    })
  }
</script>
