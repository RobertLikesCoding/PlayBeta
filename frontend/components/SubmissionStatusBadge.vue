<template>
  <UBadge
    :label="submissionStatus?.label"
    :color="submissionStatus?.color"
    class="h-fit"
  />
</template>

<script setup lang="ts">
  import type { BadgeProps } from '@nuxt/ui'
  import type { Submission } from '~/types/Submission'

  const props = defineProps<{
    submissionStatus: Submission['status']
  }>()

  interface StatusBadge {
    color: NonNullable<BadgeProps['color']>
    label: string
  }

  const submissionStatus = computed<StatusBadge | null>(() => {
    switch (props.submissionStatus) {
      case 'prep':
        return { color: 'info', label: props.submissionStatus }
      case 'live':
        return { color: 'success', label: props.submissionStatus }
      case 'closed':
        return { color: 'warning', label: props.submissionStatus }
      case 'completed':
        return { color: 'neutral', label: props.submissionStatus }
      default:
        return null
    }
  })
</script>
