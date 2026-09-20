import { describe, it, expect, beforeEach, vi } from 'vitest'
import ProfilePage from '~/pages/dev/dashboard/profile/index.vue'
import type { VueWrapper } from '@vue/test-utils'
import { flushPromises, mount } from '@vue/test-utils'

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

  beforeEach(() => {
    wrapper = mount(ProfilePage, {
      props: {
        user: user,
        isLoading: false,
      },
    })
  })

  it('should not accept insecure links', async () => {
    const websiteInput = wrapper.get('input[name="website"]')
    const form = wrapper.get('form')
    await websiteInput.setValue('http://example.com')

    await form.trigger('submit')

    const errors = wrapper.findAll('em')
    const errorTexts = errors.map((e) => e.text())

    expect(errorTexts).toContain(
      'Please provide only save URLs starting with https',
    )
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
      expect(emailInput.html()).toContain(user.email)

      await emailInput.setValue('text@abc.de')
      expect(submitButton.attributes('disabled')).not.toBeDefined()
    })
  })
})
