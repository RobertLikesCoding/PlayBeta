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

    it('a description textarea', async () => {
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

  it('should show errors if a required field was not filled out', async () => {
    const title = wrapper.find('input[name="title"]')
    const form = wrapper.find('form')

    title.setValue('Game Title')
    title.setValue('')
    await form.trigger('submit')
    const error = wrapper.findAll('em')
    const errorMessages = error.map((em) => em.text())
    console.log(
      'ERROR',
      error.map((em) => em.text()),
    )

    expect(error.length).toBe(6)
    expect(errorMessages).toContain('Title is required')
    expect(errorMessages).toContain('Description is required')
    expect(errorMessages).toContain('Please select at least 1 genre')
    expect(errorMessages).toContain('Version is required')
    expect(errorMessages).toContain('Please select at least 1 platform')
    expect(errorMessages).toContain('Please provide a link to the demo')
  })

  describe('when submitting', () => {
    it('should submit successfully if form was filled correctly', async () => {
      const titleInput = wrapper.find('input[name="title"]')
      const descriptionTextarea = wrapper.find('textarea[name="description"]')
      const genreSelect = wrapper.findComponent({ name: 'USelect' })
      const versionInput = wrapper.find('input[name="version"]')
      const platformCheckboxes = wrapper.findComponent({
        name: 'UCheckboxGroup',
      })
      const demoUrlInput = wrapper.find('input[name="demo_url"]')
      const form = wrapper.find('form')

      await titleInput.setValue('Game Title')
      await descriptionTextarea.setValue(
        'A detailed description of the game that is long enough to pass validation.',
      )
      await genreSelect.vm.$emit('update:modelValue', ['action'])
      await versionInput.setValue('1.0.0')
      await platformCheckboxes.vm.$emit('update:modelValue', ['windows'])
      await demoUrlInput.setValue('https://example.com/demo')

      await form.trigger('submit.prevent')
      await flushPromises()

      const errors = wrapper.findAll('em')
      expect(errors.length).toBe(0)
      expect((globalThis as any).submitSpy).toHaveBeenCalled()
    })

    it('should not accept insecure links', async () => {
      const demoLinkInput = wrapper.find('input[name="demo_url"]')
      const form = wrapper.find('form')
      await demoLinkInput.setValue('http://example.com')

      await form.trigger('submit')

      const errors = wrapper.findAll('em')
      expect(errors.length).toBeGreaterThan(0)
      const errorTexts = errors.map((e) => e.text())
      expect(errorTexts).toContain(
        'Please provide only safe URLs starting with https',
      )
    })
  })
})
