import { describe, it, expect, beforeEach, vi } from 'vitest'
import ProfilePage from '~/pages/tester/dashboard/profile/index.vue'
import type { VueWrapper } from '@vue/test-utils'
import { mount } from '@vue/test-utils'

vi.mock('~/composables/useCurrentUser', () => ({
  useCurrentUser: () => ({
    // user: ref(null),
    // isLoading: ref(false),
    isDev: ref(false),
    // fetchUser: vi.fn(),
    // updateUser: vi.fn(),
  }),
}))

describe('Profile Page', () => {
  const tester = {
    id: 1,
    email: 'email@abc.de',
    username: 'Robert',
    gender: undefined,
    birthdate: '13.04.1988',
  }

  let wrapper: VueWrapper

  beforeEach(() => {
    wrapper = mount(ProfilePage, {
      props: {
        user: tester,
        isLoading: false,
      },
    })
  })

  describe('validators', () => {
    it('should validate email field', async () => {
      const emailInput = wrapper.get('input[name="email"]')
      await emailInput.setValue(' ')
      await emailInput.trigger('blur')

      expect(wrapper.find('em').exists()).toBeTruthy()
    })

    it('should validate birthdate field', async () => {
      const birthdateInput = wrapper.get('input[name="birthdate"]')
      await birthdateInput.setValue('123')
      await birthdateInput.trigger('blur')

      expect(wrapper.find('em').exists()).toBeTruthy()
    })
  })

  describe('when the form is untouched', () => {
    it('the submit button should be disabled', async () => {
      const submitButton = wrapper.get('button[type="submit"]')
      expect(submitButton.attributes('disabled')).toBeDefined()
    })
  })

  describe('when the form gets filled out', () => {
    it('the submit button should be enabled', async () => {
      const submitButton = wrapper.get('button[type="submit"]')
      const emailInput = wrapper.get('input[name="email"]')

      expect(submitButton.attributes('disabled')).toBeDefined()
      expect(emailInput.html()).toContain(tester.email)

      await emailInput.setValue('text@abc.de')
      expect(submitButton.attributes('disabled')).not.toBeDefined()
    })
  })
})
