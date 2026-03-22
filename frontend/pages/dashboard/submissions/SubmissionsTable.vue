<template>
  <UTable
    :data="submissions"
    class="flex-1"
    :loading="loadingSubmissions"
    :columns="columns"
  />
</template>

<script setup lang="ts">
  import { UCheckbox } from '#components'
  import type { TableColumn } from '@nuxt/ui'
  import type { Submission } from '~/types/Submission'

  const props = defineProps<{
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
          'onUpdate:modelValue': (value: boolean | 'indeterminate') =>
            table.toggleAllPageRowsSelected(!!value),
          'aria-label': 'Select all',
        }),
      cell: ({ row }) =>
        h(UCheckbox, {
          modelValue: row.getIsSelected(),
          'onUpdate:modelValue': (value: boolean | 'indeterminate') =>
            row.toggleSelected(!!value),
          'aria-label': 'Select row',
        }),
      enableSorting: false,
      enableHiding: false,
    },
    {
      accessorKey: 'title',
      header: 'Title',
      cell: ({ row }) => row.getValue('title'),
    },
    {
      accessorKey: 'status',
      header: 'Status',
      cell: ({ row }) => row.getValue('status'),
    },
    {
      accessorKey: 'version',
      header: 'Version',
      cell: ({ row }) => row.getValue('version'),
    },
    {
      accessorKey: 'created_at',
      header: 'Created at',
      cell: ({ row }) => {
        return new Date(row.getValue('created_at')).toLocaleString('en-US', {
          day: 'numeric',
          month: 'short',
          hour: '2-digit',
          minute: '2-digit',
          hour12: false,
        })
      },
    },
  ]
</script>
