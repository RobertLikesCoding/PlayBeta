import type { GetSubmissionResponse } from '~/types/Submission'

export async function useSubmission(s_id: string) {
  const { token } = useAuth()

  const { data, pending, error } = useAsyncData(s_id, async () => {
    if (!token.value) throw new Error('No auth token')

    const response = await $fetch<GetSubmissionResponse>(
      `/api/v1/submissions/${s_id}`,
      {
        baseURL: useRuntimeConfig().public.apiBase,
        headers: {
          Authorization: `Bearer ${token.value}`,
        },
      },
    )

    if ('errors' in response) {
      console.error(response.errors.join(', '))
      throw new Error(response.errors.join(', '))
    }
    return response.data
  })

  return {
    data,
    pending,
    error,
  }
}
