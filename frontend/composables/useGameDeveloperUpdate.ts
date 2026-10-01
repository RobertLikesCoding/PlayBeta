import type {
  GameDeveloperAPI,
  UpdateGameDeveloperResponse,
} from '~/types/GameDeveloper'

type GameDeveloperUpdatePayload = Pick<
  GameDeveloperAPI,
  'email' | 'studio_name' | 'website' | 'location' | 'bio'
>

export function useGameDeveloperUpdate() {
  const { token } = useAuth()
  const toast = useToast()
  const { updateUser } = useCurrentUser()

  async function updateDeveloper(payload: GameDeveloperUpdatePayload) {
    try {
      const response = await $fetch<UpdateGameDeveloperResponse>(
        `/api/v1/game_developers/me`,
        {
          baseURL: useRuntimeConfig().public.apiBase,
          method: 'PATCH',
          headers: {
            'Content-Type': 'application/json',
            Authorization: `Bearer ${token.value}`,
          },
          body: {
            game_developer: {
              email: payload.email,
              studio_name: payload.studio_name,
              website: payload.website,
              location: payload.location,
              bio: payload.bio,
              // avatar: value.avatar,
            },
          },
        },
      )
      if (response && 'errors' in response) {
        console.error('Update failed:', response.errors)
        toast.add({
          title: 'Error',
          description: 'Saving failed. Please try again',
          color: 'error',
          icon: 'i-lucide-x-circle',
        })
      } else {
        const updatedUser = response.data
        updateUser(updatedUser)

        toast.add({
          title: 'Success',
          description: 'Your changes were saved successfully.',
          color: 'success',
          icon: 'i-lucide-check-circle',
        })
        return response
      }
    } catch (error) {
      console.error('An unexpected error occurred:', error)
    }
  }

  return {
    updateDeveloper,
  }
}
