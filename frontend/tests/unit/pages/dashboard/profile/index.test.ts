import { describe, it, expect, vi, beforeEach } from 'vitest'
import { mountSuspended } from '@nuxt/test-utils/runtime'
import ProfilePage from '~/pages/dashboard/profile/index.vue'
import { flushPromises } from '@vue/test-utils'

describe('Profile Page', () => {
  const inputFields = [
    'email',
    'avatar',
    'studio_name',
    'location',
    'website',
    'password',
    'password_confirmation',
  ]
  const user = {
    id: 1,
    email: 'email@abc.de',
    bio: '',
    website: '',
    location: 'Berlin',
    studio_name: 'GameStudio',
    avatar: '',
  }

  beforeEach(() => {
    vi.clearAllMocks()
  })

  for (const field of inputFields) {
    it(`should render the ${field} input element`, async () => {
      const wrapper = await mountSuspended(ProfilePage, {
        props: {
          user: user,
          isLoading: false,
        },
      })

      const inputElement = wrapper.find(`input[name="${field}"]`)
      expect(inputElement.exists()).toBe(true)
    })
  }

  it('should render the bio textarea element', async () => {
    const wrapper = await mountSuspended(ProfilePage, {
      props: {
        user: user,
        isLoading: false,
      },
    })

    const textarea = wrapper.find('textarea[name="bio"]')
    expect(textarea.exists()).toBe(true)
  })

  it('should render a submit button', async () => {
    const wrapper = await mountSuspended(ProfilePage, {
      props: {
        user: user,
        isLoading: false,
      },
    })

    const submitButton = wrapper.find('button[type="submit"]')
    expect(submitButton.exists()).toBe(true)
  })

  it('should render the profile section', async () => {
    const wrapper = await mountSuspended(ProfilePage, {
      props: {
        user: user,
        isLoading: false,
      },
    })

    const profileSection = wrapper.find(
      'section[data-test-id="profile-section"]',
    )
    const heading = profileSection.find('h3')
    expect(profileSection.exists()).toBe(true)
    expect(heading.text()).toContain('Profile')
  })

  it('should render the password section', async () => {
    const wrapper = await mountSuspended(ProfilePage, {
      props: {
        user: user,
        isLoading: false,
      },
    })

    const passwordSection = wrapper.find(
      'section[data-test-id="password-section"]',
    )
    const heading = passwordSection.find('h3')
    expect(passwordSection.exists()).toBe(true)
    expect(heading.text()).toContain('Password')
  })

  it('should disable submit button when form is untouched', async () => {
    const wrapper = await mountSuspended(ProfilePage, {
      props: {
        user: user,
        isLoading: false,
      },
    })

    await flushPromises()

    const submitButton = wrapper.find('button[type="submit"]')
    expect(submitButton.attributes('disabled')).toBe('')
  })

  it('should enable submit button when form is modified', async () => {
    const wrapper = await mountSuspended(ProfilePage, {
      props: {
        user: user,
        isLoading: false,
      },
    })

    await flushPromises()

    const submitButton = wrapper.find('button[type="submit"]')

    expect(submitButton.attributes('disabled')).toBeDefined
    const emailInput = wrapper.find('input[name="email"]')
    expect(emailInput.html()).toContain('email@abc.de')

    emailInput.setValue('text@abc.de')
    expect(submitButton.attributes('disabled')).not.toBeDefined
  })
})
