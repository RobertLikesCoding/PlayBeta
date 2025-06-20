export const useAuth = () => {
  const token = useCookie<string | null>('auth_token', {
    sameSite: 'lax',
    path: '/',
    secure: process.env.NODE_ENV === 'production',
    maxAge: 60 * 60 * 24 * 7, // 7 days in seconds
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
