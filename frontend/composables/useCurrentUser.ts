import type { GameDeveloperAPI } from '~/types/GameDeveloper'
import type { GameTesterAPI } from '~/types/GameTesterAPI'

type CurrentUserResponse = {
  data: UserType
}

type UserType = GameDeveloperAPI | GameTesterAPI
const user = ref<UserType | null>(null)
const route = useRoute()
const isDev = computed(() => route.path.startsWith('/dev/'))

const isLoading = ref(true)

export function useCurrentUser() {
  const { token, isAuthenticated } = useAuth()

  async function fetchUser() {
    if (user.value && isAuthenticated.value) {
      isLoading.value = false
      return user.value
    }
    const queryPath = isDev.value
      ? '/api/v1/game_developers/me'
      : '/api/v1/game_testers/me'

    try {
      const response = await $fetch<CurrentUserResponse>(queryPath, {
        baseURL: useRuntimeConfig().public.apiBase,
        headers: { Authorization: `Bearer ${token.value}` },
      })

      user.value = response.data
    } catch (error) {
      console.error('Failed to fetch current user.', error)
    } finally {
      isLoading.value = false
    }
    return user.value
  }

  function updateUser(updatedUser: UserType) {
    user.value = updatedUser
  }

  return { user, isLoading, isDev, fetchUser, updateUser }
}
