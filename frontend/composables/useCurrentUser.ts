import type { GameDeveloperAPI } from '~/types/GameDeveloper'

const user = ref<GameDeveloperAPI | null>(null)
const isLoading = ref(true)

export function useCurrentUser() {
  const { token, isAuthenticated } = useAuth()

  async function fetchUser() {
    isLoading.value = true

    if (user.value && isAuthenticated.value) {
      isLoading.value = false
      return user.value
    }

    try {
      user.value = await $fetch('/api/v1/game_developers/me', {
        baseURL: useRuntimeConfig().public.apiBase,
        headers: { Authorization: `Bearer ${token.value}` },
      })
    } catch (error) {
      console.error('Failed to fetch current user')
    } finally {
      isLoading.value = false
    }
    return user.value
  }

  return { user, isLoading, fetchUser }
}
