import { describe, it, expect, beforeEach, vi } from 'vitest'
import ProfilePage from '~/pages/dev/dashboard/profile/index.vue'
import type { VueWrapper } from '@vue/test-utils'
import { mount } from '@vue/test-utils'

vi.mock('~/composables/useCurrentUser', () => ({
  useCurrentUser: () => ({
    // user: ref(null),
    // isLoading: ref(false),
    isDev: ref(true),
    // fetchUser: vi.fn(),
    // updateUser: vi.fn(),
  }),
}))

describe('Profile Page', () => {
  const developer = {
    id: 1,
    email: 'email@abc.de',
    bio: '',
    website: '',
    location: 'Berlin',
    studio_name: 'GameStudio',
    avatar: '',
  }

  let wrapper: VueWrapper

  beforeEach(() => {
    wrapper = mount(ProfilePage, {
      props: {
        user: developer,
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

    it('should validate website field', async () => {
      const websiteInput = wrapper.get('input[name="website"]')
      await websiteInput.setValue('hello')
      await websiteInput.trigger('blur')

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
      expect(emailInput.html()).toContain(developer.email)

      await emailInput.setValue('text@abc.de')
      expect(submitButton.attributes('disabled')).not.toBeDefined()
    })
  })
})
