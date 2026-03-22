import type { GetSubmissionsListResponse, Submission } from '~/types/Submission'

const submissions = ref<Submission[] | null>(null)
const isLoading = ref(true)
const error = ref<string | null>(null)

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

      if (!response.success) {
        throw new Error(response.errors.join(', '))
      }

      return response.data
    },
  )

  return { data, pending, error }
}
