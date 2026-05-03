import { flushPromises, mount, VueWrapper } from '@vue/test-utils'
import { beforeEach, describe, expect, it, vi } from 'vitest'
import SettingsPage from '~/pages/dashboard/settings/index.vue'

describe('Settings Page', () => {
  let wrapper: VueWrapper

  beforeEach(() => {
    vi.clearAllMocks()
    wrapper = mount(SettingsPage)
  })

  it('should disable submit button when form is untouched', async () => {
    const submitButton = wrapper.get('button[type="submit"]')
    expect(submitButton.attributes('disabled')).toBeDefined()
  })

  describe('validations', () => {
    it('should show error messages for missing fields', async () => {
      const currentPasswordInput = wrapper.get('input[name="current_password"]')
      const form = wrapper.get('form')

      await currentPasswordInput.setValue('something')
      await currentPasswordInput.setValue('')
      await currentPasswordInput.trigger('blur')
      await form.trigger('submit')

      await flushPromises()
      const errorMessages = wrapper.findAll('em')
      expect(errorMessages.length).toBe(3)
    })

    it('should show error message when new password is too short', async () => {
      const newPasswordInput = wrapper.get('input[name="new_password"]')
      const form = wrapper.get('form')

      await newPasswordInput.setValue('short')
      await newPasswordInput.trigger('blur')
      await form.trigger('submit')

      await flushPromises()
      expect(wrapper.html()).toContain('Password must be at least 8 characters')
    })

    it('should show error message when password confirmation does not match', async () => {
      const confirmationInput = wrapper.get(
        'input[name="new_password_confirmation"]',
      )
      const form = wrapper.get('form')

      await confirmationInput.setValue('longpassword')
      await confirmationInput.trigger('blur')
      await form.trigger('submit')

      await flushPromises()
      expect(wrapper.html()).toContain('Passwords do not match')
    })
  })

  describe('the submit button', () => {
    it('should enable when form is modified', async () => {
      const submitButton = wrapper.get('button[type="submit"]')
      const currentPasswordInput = wrapper.get('input[name="current_password"]')

      await currentPasswordInput.setValue('somePassword')

      expect(submitButton.attributes('disabled')).not.toBeDefined()
    })

    it('should change button label on successful submission', async () => {
      const submitButton = wrapper.get('button[type="submit"]')
      const form = wrapper.get('form')
      const currentPasswordInput = wrapper.get('input[name="current_password"]')
      const newPassword = wrapper.get('input[name="new_password"]')
      const newPasswordConfirmation = wrapper.get(
        'input[name="new_password_confirmation"]',
      )

      await currentPasswordInput.setValue('oldPassword')
      await newPassword.setValue('newPassword')
      await newPasswordConfirmation.setValue('newPassword')
      await form.trigger('submit')
      await flushPromises()

      expect(submitButton.text()).toBe('Changes saved!')
    })
  })
})
