import { describe, it, expect, vi, beforeEach } from 'vitest'
import { mountSuspended } from '@nuxt/test-utils/runtime'
import Navbar from '~/components/Navbar.vue'

let mockIsAuthenticated = false
let mockToken: string | null = null
const clearTokenMock = vi.fn()

vi.mock('~/composables/useAuth', () => ({
  useAuth: () => ({
    isAuthenticated: mockIsAuthenticated,
    token: mockToken,
    setToken: () => {},
    clearToken: clearTokenMock,
  }),
}))

function mockAuth(isAuthenticated: boolean, token: string | null) {
  mockIsAuthenticated = isAuthenticated
  mockToken = token
}

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
      mockAuth(false, null) // default state
    })

    it('should link to signup if user is not logged in', async () => {
      mockAuth(false, null)
      const wrapper = await mountSuspended(Navbar)
      const accountLink = wrapper
        .findAllComponents({ name: 'NuxtLink' })
        .find((link) => link.text() === 'Account')

      expect(accountLink?.props('to')).toBe('/auth/signup')
    })

    it('should link to dashboard if user is logged in', async () => {
      mockAuth(true, 'someToken')
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
