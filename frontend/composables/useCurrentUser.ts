import type { GameDeveloperAPI } from '~/types/GameDeveloper'

const user = ref<GameDeveloperAPI | null>(null)
const loaded = ref(false)

export function useCurrentUser() {
  const { token, isAuthenticated } = useAuth()

  async function fetchUser() {
    if (!loaded.value && isAuthenticated) {
      user.value = await $fetch('/api/v1/game_developers/me', {
        baseURL: useRuntimeConfig().public.apiBase,
        headers: { Authorization: `Bearer ${token.value}` },
      })
      loaded.value = true
    }
    return user.value
  }
  return { user, fetchUser }
}
