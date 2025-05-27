export const useAuth = () => {
  const token = useCookie<string | null>('auth_token', {
    sameSite: 'lax',
    path: '/',
    secure: process.env.NODE_ENV === 'production',
  })

  const isAuthenticated = computed(() => {
    return !!token.value
  })

  const setToken = (newToken: string) => {
    token.value = newToken
  }

  const clearToken = () => {
    token.value = null
  }

  return {
    token,
    isAuthenticated,
    setToken,
    clearToken,
  }
}
