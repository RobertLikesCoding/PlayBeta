import type { SubmissionConstants } from '~/types/Submission'

export async function useConstants() {
  const { platforms, genres } = await $fetch<SubmissionConstants>(
    '/api/v1/submissions/constants',
    {
      baseURL: useRuntimeConfig().public.apiBase,
    },
  )

  const genreList = computed(() => {
    return genres.map((genre) => ({
      label: genre.name,
      value: String(genre.id),
    }))
  })
  const platformList = computed(() => {
    return platforms.map((platform) => ({
      label: platform.name,
      value: String(platform.id),
    }))
  })

  return {
    genreList,
    platformList,
  }
}
