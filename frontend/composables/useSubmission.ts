import type {
  CreateSubmissionResponse,
  GetSubmissionResponse,
  SubmissionStatus,
} from '~/types/Submission'

export function useSubmission(s_id: string) {
  const { token } = useAuth()

  const { data, pending, error } = useAsyncData(
    `submission-${s_id}`,
    async () => {
      if (!token.value) return null

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
    },
  )

  return {
    data,
    pending,
    error,
  }
}

interface CreateSubmissionPayload {
  submission: {
    title?: string
    description?: string
    genre_ids?: number[]
    platform_ids?: number[]
    demo_url?: string
    version?: string
    status?: SubmissionStatus
  }
}

export async function saveSubmission({
  requestPath,
  payload,
  method,
}: {
  requestPath: string
  payload: CreateSubmissionPayload
  method: 'POST' | 'PATCH'
}) {
  const { token } = useAuth()

  const response = await $fetch<CreateSubmissionResponse>(requestPath, {
    baseURL: useRuntimeConfig().public.apiBase,
    method: method,
    headers: {
      'Content-Type': 'application/json',
      Authorization: `Bearer ${token.value}`,
    },
    body: payload,
  })

  return {
    response,
  }
}
