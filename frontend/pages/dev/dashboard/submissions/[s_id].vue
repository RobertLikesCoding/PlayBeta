<template>
  <div class="flex flex-col gap-5">
    <div class="flex justify-between items-center">
      <BackButton to="/dev/dashboard/submissions" />
      <div class="flex gap-2">
        <UModal
          title="Change Submission Status"
          description="Please choose the state you want to change the submission to."
        >
          <UButton
            :disabled="data?.status === 'completed'"
            variant="outline"
            label="Change Status"
          />

          <template #body>
            Change State to:
            <USelect
              v-model="selectedStatus"
              :items="availableStatusOptions"
              class="w-full mt-2"
            />
          </template>
          <template #footer>
            <div class="flex w-full justify-end">
              <UButton
                label="Submit Status Change"
                @click="handleStatusChange"
              />
            </div>
          </template>
        </UModal>
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
  import { UButton, UModal } from '#components'
  import BackButton from '~/components/common/BackButton.vue'
  import LoadingSpinner from '~/components/common/LoadingSpinner.vue'
  import type { SubmissionStatus } from '~/types/Submission'

  const route = useRoute()
  const s_id = route.params.s_id as string

  const { data, pending: isLoading, error } = useSubmission(s_id)

  const submissionGenres = computed(() =>
    data.value?.genres.map((genre) => genre.name).join(', '),
  )
  const submissionPlatforms = computed(() =>
    data.value?.platforms.map((pf) => pf.name).join(', '),
  )

  const STATUS_TRANSITIONS: Record<SubmissionStatus, SubmissionStatus[]> = {
    prep: ['live'],
    live: ['closed', 'completed'],
    closed: ['live', 'completed'],
    completed: [],
  }

  const availableStatusOptions = computed<SubmissionStatus[]>(() =>
    data.value?.status ? STATUS_TRANSITIONS[data.value.status] : [],
  )
  const selectedStatus = ref<SubmissionStatus>()

  watch(availableStatusOptions, (options) => {
    if (!options) return
    if (!selectedStatus.value || !options.includes(selectedStatus.value)) {
      selectedStatus.value = options[0]
    }
  })

  function handleStatusChange() {
    if (!selectedStatus.value) return

    const payload = {
      submission: { status: selectedStatus.value },
    }
    saveSubmission({
      method: 'PATCH',
      requestPath: `/api/v1/submissions/${s_id}`,
      payload: payload,
    })
  }
</script>
