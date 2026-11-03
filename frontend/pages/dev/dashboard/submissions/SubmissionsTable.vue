<template>
  <UTable
    :data="submissions"
    class="flex-1"
    :loading="loadingSubmissions"
    :columns="columns"
    empty="No Submissions found."
    :ui="{ td: 'cursor-pointer' }"
    @select="onSelect"
  />
</template>

<script setup lang="ts">
  import { UCheckbox } from '#components'
  import type { TableColumn, TableRow } from '@nuxt/ui'
  import SubmissionStatusBadge from '~/components/SubmissionStatusBadge.vue'
  import type { Submission } from '~/types/Submission'

  defineProps<{
    submissions: Submission[] | undefined
    loadingSubmissions: boolean
  }>()

  const columns: TableColumn<Submission>[] = [
    {
      id: 'select',
      header: ({ table }) =>
        h(UCheckbox, {
          modelValue: table.getIsSomePageRowsSelected()
            ? 'indeterminate'
            : table.getIsAllPageRowsSelected(),
          'onUpdate:modelValue': (value: unknown) =>
            table.toggleAllPageRowsSelected(value === true),
          'aria-label': 'Select all',
        }),
      cell: ({ row }) =>
        h(UCheckbox, {
          modelValue: row.getIsSelected(),
          'onUpdate:modelValue': (value: unknown) =>
            row.toggleSelected(value === true),
          'aria-label': 'Select row',
        }),
      enableSorting: false,
      enableHiding: false,
    },
    {
      accessorKey: 'title',
      header: 'Title',
      cell: ({ row }) => row.original.title,
    },
    {
      accessorKey: 'status',
      header: 'Status',
      cell: ({ row }) =>
        h(SubmissionStatusBadge, {
          submissionStatus: row.original.status,
        }),
    },
    {
      accessorKey: 'version',
      header: 'Version',
      cell: ({ row }) => row.original.version,
    },
    {
      accessorKey: 'created_at',
      header: 'Created at',
      cell: ({ row }) => {
        return new Date(row.original.created_at).toLocaleString('en-US', {
          day: 'numeric',
          month: 'short',
          hour: '2-digit',
          minute: '2-digit',
          hour12: false,
        })
      },
    },
  ]

  async function onSelect(e: Event, row: TableRow<Submission>) {
    const submission_id = row.original.s_id

    await navigateTo(`/dev/dashboard/submissions/${submission_id}`)
  }
</script>
