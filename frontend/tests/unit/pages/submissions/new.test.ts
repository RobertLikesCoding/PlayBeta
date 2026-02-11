import { describe, it, expect, vi, beforeEach } from 'vitest'
import { mountSuspended } from '@nuxt/test-utils/runtime'
import NewSubmissionPage from '~/pages/dashboard/submissions/new.vue'
import { flushPromises, VueWrapper } from '@vue/test-utils'

describe('Submission New Page', () => {
  let wrapper: VueWrapper
  beforeEach(async () => {
    wrapper = await mountSuspended(NewSubmissionPage)
  })

  describe('should render', () => {
    it('a heading', async () => {
      const heading = wrapper.find('h2')
      expect(heading.exists()).toBe(true)
      expect(heading.text()).toBe('Create a new submission')
    })

    it('a basic information section', async () => {
      const section = wrapper.find('section[data-test-id="basic-info-section"]')
      expect(section.exists()).toBe(true)
    })

    it('a title input field', async () => {
      const input = wrapper.find('input[name="title"]')
      expect(input.exists()).toBe(true)
    })

    it('a description input textarea', async () => {
      const textarea = wrapper.find('textarea[name="description"]')
      expect(textarea.exists()).toBe(true)
    })

    it('a genre select element', async () => {
      const dropdown = wrapper.find('#genre')
      expect(dropdown.exists()).toBe(true)
    })

    it('a version input field', async () => {
      const input = wrapper.find('input[name="version"]')
      expect(input.exists()).toBe(true)
    })

    it('platform checkboxes', async () => {
      const checkboxes = wrapper.findAll('button[role="checkbox"]')
      expect(checkboxes.length).toBe(4)
    })

    it('a demo link input field', async () => {
      const input = wrapper.find('input[name="demo_url"]')
      expect(input.exists()).toBe(true)
    })
  })

  it('should disable submit button when form is untouched', async () => {
    await flushPromises()

    const submitButton = wrapper.find('button[type="submit"]')
    expect(submitButton.attributes('disabled')).toBe('')
  })

  it('should enable submit button when form is modified', async () => {
    await flushPromises()

    const submitButton = wrapper.find('button[type="submit"]')
    expect(submitButton.attributes('disabled')).toBeDefined()
    const emailInput = wrapper.find('input[name="title"]')

    await emailInput.setValue('a game title')
    await flushPromises()
    expect(submitButton.attributes('disabled')).not.toBeDefined()
  })

  it('should show info if a required field was not filled out', () => {})

  describe('demo link field', () => {
    it('should accept secure links', () => {})
    it('should not accept insecure links', () => {})
  })
})
