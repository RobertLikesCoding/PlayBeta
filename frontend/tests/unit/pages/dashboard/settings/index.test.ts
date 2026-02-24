import { describe, it, expect, vi, beforeEach } from 'vitest'
import { mountSuspended } from '@nuxt/test-utils/runtime'
import SettingsPage from '~/pages/dashboard/settings/index.vue'
import { flushPromises, VueWrapper } from '@vue/test-utils'

vi.stubGlobal(
  '$fetch',
  vi.fn().mockResolvedValue({
    message: 'Successfully updated user data',
  }),
)

describe('Settings Page', () => {
  const inputFields = [
    'current_password',
    'new_password',
    'new_password_confirmation',
  ]

  let wrapper: VueWrapper

  beforeEach(async () => {
    vi.clearAllMocks()
    wrapper = await mountSuspended(SettingsPage)
  })

  for (const field of inputFields) {
    it(`should render the ${field} input element`, async () => {
      const inputElement = wrapper.find(`input[name="${field}"]`)
      expect(inputElement.exists()).toBe(true)
    })
  }

  it('should render a submit button', async () => {
    const submitButton = wrapper.find('button[type="submit"]')
    expect(submitButton.exists()).toBe(true)
  })

  it('should render the password section', async () => {
    const passwordSection = wrapper.find(
      'section[data-test-id="password-section"]',
    )
    const heading = passwordSection.find('h3')
    expect(passwordSection.exists()).toBe(true)
    expect(heading.text()).toContain('Set new password')
  })

  it('should disable submit button when form is untouched', async () => {
    const submitButton = wrapper.find('button[type="submit"]')
    expect(submitButton.attributes('disabled')).toBe('')
  })

  describe('validations', () => {
    it('should show error messages for missing fields', async () => {
      const currentPasswordInput = wrapper.find(
        'input[name="current_password"]',
      )
      const form = wrapper.find('form')

      await currentPasswordInput.setValue('something')
      await currentPasswordInput.setValue('')
      await currentPasswordInput.trigger('blur')
      await form.trigger('submit')

      await flushPromises()
      const errorMessages = wrapper.findAll('em')
      expect(errorMessages.length).toBe(3)
    })

    it('should show error message when new password is too short', async () => {
      const newPasswordInput = wrapper.find('input[name="new_password"]')
      const form = wrapper.find('form')

      await newPasswordInput.setValue('short')
      await newPasswordInput.trigger('blur')
      await form.trigger('submit')

      await flushPromises()
      expect(wrapper.html()).toContain('Password must be at least 8 characters')
    })

    it('should show error message when password confirmation does not match', async () => {
      const confirmationInput = wrapper.find(
        'input[name="new_password_confirmation"]',
      )
      const form = wrapper.find('form')

      await confirmationInput.setValue('longpassword')
      await confirmationInput.trigger('blur')
      await form.trigger('submit')

      await flushPromises()
      expect(wrapper.html()).toContain('Passwords do not match')
    })
  })

  describe('the submit button', () => {
    it('should enable when form is modified', async () => {
      const submitButton = wrapper.find('button[type="submit"]')
      const currentPasswordInput = wrapper.find(
        'input[name="current_password"]',
      )

      expect(submitButton.attributes('disabled')).toBeDefined()
      await currentPasswordInput.setValue('somePassword')
      const inputElement = currentPasswordInput.element as HTMLInputElement
      expect(inputElement.value).toBe('somePassword')

      expect(submitButton.attributes('disabled')).not.toBeDefined()
    })

    it('should change button label on successful submission', async () => {
      const submitButton = wrapper.find('button[type="submit"]')
      const form = wrapper.find('form')
      const currentPasswordInput = wrapper.find(
        'input[name="current_password"]',
      )
      const newPassword = wrapper.find('input[name="new_password"]')
      const newPasswordConfirmation = wrapper.find(
        'input[name="new_password_confirmation"]',
      )

      await currentPasswordInput.setValue('oldPassword')
      await newPassword.setValue('newPassword')
      await newPasswordConfirmation.setValue('newPassword')
      await form.trigger('submit')
      await flushPromises()

      expect(globalThis.$fetch).toHaveBeenCalled()
      expect(submitButton.text()).toBe('Changes saved!')
    })

    it('should send a PATCH request with the correct body', async () => {
      const form = wrapper.find('form')
      const currentPasswordInput = wrapper.find(
        'input[name="current_password"]',
      )
      const newPassword = wrapper.find('input[name="new_password"]')
      const newPasswordConfirmation = wrapper.find(
        'input[name="new_password_confirmation"]',
      )

      await currentPasswordInput.setValue('oldPassword')
      await newPassword.setValue('newPassword')
      await newPasswordConfirmation.setValue('newPassword')
      await form.trigger('submit')
      await flushPromises()

      expect(globalThis.$fetch).toHaveBeenCalled()
      expect(globalThis.$fetch).toHaveBeenCalledWith(
        '/api/v1/passwords/update',
        expect.objectContaining({
          body: {
            password_changes: {
              current_password: 'oldPassword',
              new_password: 'newPassword',
              new_password_confirmation: 'newPassword',
            },
          },
        }),
      )
    })
  })
})
