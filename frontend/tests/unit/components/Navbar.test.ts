import { describe, it, expect, vi, beforeEach } from 'vitest'
import { mountSuspended } from '@nuxt/test-utils/runtime'
import Navbar from '~/components/Navbar.vue'

const mockIsAuthenticated = ref(false)
const mockToken = { value: 'test-token' }

vi.mock('~/composables/useAuth', () => ({
  useAuth: () => ({
    isAuthenticated: mockIsAuthenticated,
    token: mockToken,
    setToken: vi.fn(),
    clearToken: vi.fn(),
  }),
}))

describe('Navbar', () => {
  it('renders the brand name', async () => {
    const wrapper = await mountSuspended(Navbar)
    expect(wrapper.text()).toContain('PlayBeta')
  })

  it('renders 3 navbar items', async () => {
    const wrapper = await mountSuspended(Navbar)

    const desktopItems = wrapper.find('.hidden')
    expect(desktopItems.findAll('a').length).toEqual(4)
  })

  describe('Account Button', () => {
    beforeEach(() => {
      vi.clearAllMocks()
    })

    it('should link to signup if user is not logged in', async () => {
      const wrapper = await mountSuspended(Navbar)
      const accountLink = wrapper
        .findAllComponents({ name: 'NuxtLink' })
        .find((link) => link.text() === 'Account')

      expect(accountLink?.props('to')).toBe('/auth/signup')
    })

    it('should link to dashboard if user is logged in', async () => {
      mockIsAuthenticated.value = true

      const wrapper = await mountSuspended(Navbar)
      const accountLink = wrapper
        .findAllComponents({ name: 'NuxtLink' })
        .find((link) => link.text() === 'Account')

      expect(accountLink?.props('to')).toBe('/dashboard/submissions')
    })
  })

  describe('Logout button', () => {
    it('should call clearToken when logging out', async () => {
      const wrapper = await mountSuspended(Navbar)
      const logoutButton = wrapper
        .findAll('button')
        .find((btn) => btn.text() === 'Logout')

      await logoutButton?.trigger('click')

      expect(clearTokenMock).toHaveBeenCalled()
    })
  })
})
