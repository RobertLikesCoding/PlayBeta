import { flushPromises } from '@vue/test-utils'
import { mockNuxtImport, mountSuspended } from '@nuxt/test-utils/runtime'
import { beforeEach, describe, expect, it, vi } from 'vitest'
import SignUpForm from '~/components/common/SignUpForm.vue'

const { fetchMock, navigateToMock, setTokenCookieMock, useAuthMock } =
  vi.hoisted(() => ({
    fetchMock: vi.fn(),
    navigateToMock: vi.fn(),
    setTokenCookieMock: vi.fn(),
    useAuthMock: vi.fn(() => ({
      isAuthenticated: { value: true },
      setTokenCookie: setTokenCookieMock,
    })),
  }))

mockNuxtImport('$fetch', () => fetchMock)
mockNuxtImport('navigateTo', () => navigateToMock)
mockNuxtImport('useAuth', () => useAuthMock)

describe('SignUpForm', () => {
  beforeEach(() => {
    vi.clearAllMocks()
    fetchMock.mockResolvedValue({
      data: { id: 1, token: 'signup-token' },
      message: 'Successfully created user',
    })
  })

  it('stores the signup token and redirects a tester to the dashboard', async () => {
    const wrapper = await mountSuspended(SignUpForm, {
      props: {
        accountType: 'tester',
        infoText: 'Tester signup',
      },
    })

    await wrapper.get('input[name="email"]').setValue('tester@example.com')
    await wrapper.get('input[name="password"]').setValue('password123')
    await wrapper
      .get('input[name="password_confirmation"]')
      .setValue('password123')
    await wrapper.get('input[name="birthdate"]').setValue('1990-01-01')

    for (const name of [
      'email',
      'password',
      'password_confirmation',
      'birthdate',
    ]) {
      await wrapper.get(`input[name="${name}"]`).trigger('blur')
    }
    await flushPromises()

    await wrapper.get('form').trigger('submit')
    await flushPromises()

    expect(setTokenCookieMock).toHaveBeenCalledWith('signup-token', 'tester')
    expect(navigateToMock).toHaveBeenCalledWith('/tester/dashboard/profile')
  })
})
