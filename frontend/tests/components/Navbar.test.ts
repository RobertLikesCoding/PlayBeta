import { describe, it, expect, vi, beforeEach } from 'vitest'
import { mountSuspended } from '@nuxt/test-utils/runtime'
import NavBar from '~/components/NavBar.vue'
import { ref } from 'vue'

const mockIsAuthenticated = ref(false)
const mockToken = { value: 'test-token' }
const clearTokenMock = vi.fn()

vi.mock('~/composables/useAuth', () => ({
  useAuth: () => ({
    isAuthenticated: mockIsAuthenticated,
    token: mockToken,
    setToken: vi.fn(),
    clearToken: clearTokenMock,
  }),
}))

describe('NavBar', () => {
  describe('Account Button', () => {
    beforeEach(() => {
      vi.clearAllMocks()
    })

    it('should link to signup if user is not logged in', async () => {
      const wrapper = await mountSuspended(NavBar)
      const accountLink = wrapper
        .findAllComponents({ name: 'NuxtLink' })
        .find((link) => link.text() === 'Account')

      expect(accountLink?.props('to')).toBe('/auth/signup')
    })

    it('should link to dashboard if user is logged in', async () => {
      mockIsAuthenticated.value = true

      const wrapper = await mountSuspended(NavBar)
      const accountLink = wrapper
        .findAllComponents({ name: 'NuxtLink' })
        .find((link) => link.text() === 'Account')

      expect(accountLink?.props('to')).toBe('/dashboard/submissions')
    })
  })

  describe('Logout button', () => {
    it('should call clearToken when logging out', async () => {
      const wrapper = await mountSuspended(NavBar)
      const logoutButton = wrapper
        .findAll('button')
        .find((btn) => btn.text() === 'Logout')

      await logoutButton?.trigger('click')

      expect(clearTokenMock).toHaveBeenCalled()
    })
  })
})
