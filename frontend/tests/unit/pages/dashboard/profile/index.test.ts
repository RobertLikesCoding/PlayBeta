import { describe, it, expect, vi, beforeEach } from 'vitest'
import { mountSuspended } from '@nuxt/test-utils/runtime'
import ProfilePage from '~/pages/dashboard/profile/index.vue'
import { flushPromises, VueWrapper } from '@vue/test-utils'

vi.stubGlobal(
  '$fetch',
  vi.fn().mockResolvedValue({
    message: 'Successfully updated user data',
  }),
)

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

  let wrapper: VueWrapper

  beforeEach(async () => {
    vi.clearAllMocks()
    wrapper = await mountSuspended(ProfilePage, {
      props: {
        user: user,
        isLoading: false,
      },
    })
  })

  for (const field of inputFields) {
    it(`should render the ${field} input element`, async () => {
      const inputElement = wrapper.find(`input[name="${field}"]`)
      expect(inputElement.exists()).toBe(true)
    })
  }

  it('should render the bio textarea element', async () => {
    const textarea = wrapper.find('textarea[name="bio"]')
    expect(textarea.exists()).toBe(true)
  })

  it('should render a submit button', async () => {
    const submitButton = wrapper.find('button[type="submit"]')
    expect(submitButton.exists()).toBe(true)
  })

  it('should render the profile section', async () => {
    const profileSection = wrapper.find(
      'section[data-test-id="profile-section"]',
    )
    const heading = profileSection.find('h3')
    expect(profileSection.exists()).toBe(true)
    expect(heading.text()).toContain('Profile')
  })

  it('should render the password section', async () => {
    const passwordSection = wrapper.find(
      'section[data-test-id="password-section"]',
    )
    const heading = passwordSection.find('h3')
    expect(passwordSection.exists()).toBe(true)
    expect(heading.text()).toContain('Password')
  })

  it('should disable submit button when form is untouched', async () => {
    const submitButton = wrapper.find('button[type="submit"]')
    expect(submitButton.attributes('disabled')).toBe('')
  })

  it('should enable submit button when form is modified', async () => {
    const submitButton = wrapper.find('button[type="submit"]')
    const emailInput = wrapper.find('input[name="email"]')

    expect(submitButton.attributes('disabled')).toBeDefined()
    expect(emailInput.html()).toContain(user.email)

    await emailInput.setValue('text@abc.de')
    expect(submitButton.attributes('disabled')).not.toBeDefined()
  })

  describe('the submit button', () => {
    it('should change button label on successful submission', async () => {
      const submitButton = wrapper.find('button[type="submit"]')
      const form = wrapper.find('form')
      const emailInput = wrapper.find('input[name="email"]')

      await emailInput.setValue('text@abc.de')
      await form.trigger('submit')
      await flushPromises()

      expect(globalThis.$fetch).toHaveBeenCalled()
      expect(submitButton.text()).toBe('Changes saved!')
    })

    it('should send a PATCH request with the correct body', async () => {
      const form = wrapper.find('form')
      const emailInput = wrapper.find('input[name="email"]')

      await emailInput.setValue('text@abc.de')
      await form.trigger('submit')
      await flushPromises()

      expect(globalThis.$fetch).toHaveBeenCalled()
      expect(globalThis.$fetch).toHaveBeenCalledWith(
        '/api/v1/game_developers/me',
        expect.objectContaining({
          body: {
            game_developer: expect.objectContaining({
              email: 'text@abc.de',
            }),
          },
        }),
      )
    })
  })
})
