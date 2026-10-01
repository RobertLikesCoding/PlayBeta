import { describe, it, expect, vi, beforeEach } from 'vitest'
import { mountSuspended } from '@nuxt/test-utils/runtime'
import NavBar from '~/components/NavBar.vue'

const { mockState, clearTokenCookieMock } = vi.hoisted(() => {
  return {
    mockState: { isAuthenticated: false, isDev: true },
    clearTokenCookieMock: vi.fn(),
  }
})

vi.mock('~/composables/useAuth', () => ({
  useAuth: () => ({
    isAuthenticated: mockState.isAuthenticated,
    token: { value: 'test-token' },
    setTokenCookie: vi.fn(),
    clearTokenCookie: clearTokenCookieMock,
    isDev: mockState.isDev,
  }),
}))

describe('NavBar', () => {
  beforeEach(() => {
    vi.clearAllMocks()
  })

  describe('Account Button', () => {
    it('should link to signup if user is not logged in', async () => {
      const wrapper = await mountSuspended(NavBar)
      const accountLink = wrapper
        .findAllComponents({ name: 'NuxtLink' })
        .find((link) => link.text() === 'Account')

      expect(accountLink?.props('to')).toBe('/dev/auth/signup')
    })

    it('should link to dashboard if user is logged in', async () => {
      mockState.isAuthenticated = true

      const wrapper = await mountSuspended(NavBar)
      const accountLink = wrapper
        .findAllComponents({ name: 'NuxtLink' })
        .find((link) => link.text() === 'Account')

      expect(accountLink?.props('to')).toBe('/dev/dashboard/submissions')
    })
  })

  describe('Logout button', () => {
    it('should call clearTokenCookie when logging out', async () => {
      const wrapper = await mountSuspended(NavBar)
      const logoutButton = wrapper
        .findAll('button')
        .find((btn) => btn.text() === 'Logout')

      await logoutButton?.trigger('click')

      expect(clearTokenCookieMock).toHaveBeenCalled()
    })
  })
})
