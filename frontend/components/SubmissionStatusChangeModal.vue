<template>
  <UModal
    v-model:open="isOpen"
    title="Change Submission Status"
    description="Please choose the state you want to change the submission to."
  >
    <UButton
      :disabled="submissionStatus === 'completed'"
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
          :loading="loading"
          :disabled="loading"
          @click="submitStatusChange"
        />
      </div>
    </template>
  </UModal>
</template>

<script setup lang="ts">
  import {
    ALLOWED_STATUS_TRANSITIONS,
    type SubmissionStatus,
  } from '~/types/Submission'

  const props = defineProps<{
    submissionStatus: SubmissionStatus
    loading: boolean
  }>()

  const emit = defineEmits<{
    selectedStatus: [status: SubmissionStatus]
  }>()

  const isOpen = ref(false)

  const submitStatusChange = () => {
    if (selectedStatus.value) {
      emit('selectedStatus', selectedStatus.value)
    }
  }

  const availableStatusOptions = computed<SubmissionStatus[]>(() =>
    props.submissionStatus
      ? ALLOWED_STATUS_TRANSITIONS[props.submissionStatus]
      : [],
  )
  const selectedStatus = ref<SubmissionStatus>()

  watch(
    availableStatusOptions,
    (options) => {
      if (!options) return
      if (!selectedStatus.value || !options.includes(selectedStatus.value)) {
        selectedStatus.value = options[0]
      }
    },
    { immediate: true },
  )

  watch(
    () => props.loading,
    (loading, wasLoading) => {
      if (wasLoading && !loading) {
        isOpen.value = false
      }
    },
  )
</script>
