import type { GetSubmissionsListResponse } from '~/types/Submission'

export const useSubmissionsList = () => {
  const { token } = useAuth()
  const toast = useToast()

  const { data, pending, error, refresh } = useAsyncData(
    'submissions',
    async () => {
      if (!token.value) throw new Error('No auth token')

      const response = await $fetch<GetSubmissionsListResponse>(
        '/api/v1/submissions',
        {
          baseURL: useRuntimeConfig().public.apiBase,
          headers: {
            Authorization: `Bearer ${token.value}`,
          },
        },
      )

      if ('errors' in response) {
        toast.add({
          title: 'Error',
          description: 'Failed to load your submissions.',
          color: 'error',
          icon: 'i-lucide-x-circle',
        })
        throw new Error(response.errors.join(', '))
      }

      return response.data
    },
  )

  return { data, pending, error }
}
