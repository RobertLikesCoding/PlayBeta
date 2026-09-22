import type { AccountType } from '~/types/misc'

export const useAuth = () => {
  const token = useCookie<string | null>('auth_token', {
    sameSite: 'lax',
    path: '/',
    secure: process.env.NODE_ENV === 'production',
    maxAge: 60 * 60 * 24 * 7, // 7 days in seconds
  })

  const accountType = useCookie<AccountType | null>('account_type', {
    sameSite: 'lax',
    path: '/',
  })

  const isAuthenticated = computed(() => {
    return !!token.value
  })

  const isDev = computed(() => accountType.value === 'dev')

  const setTokenCookie = (newToken: string, type: AccountType) => {
    token.value = newToken
    accountType.value = type
  }

  const clearTokenCookie = () => {
    token.value = null
    accountType.value = null
  }

  return {
    token,
    isAuthenticated,
    isDev,
    setTokenCookie,
    clearTokenCookie,
  }
}
