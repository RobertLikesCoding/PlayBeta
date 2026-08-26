import { describe, it, expect, vi, beforeEach } from 'vitest'
import { mountSuspended } from '@nuxt/test-utils/runtime'
import NewSubmissionPage from '~/pages/dashboard/submissions/new.vue'
import { flushPromises, VueWrapper } from '@vue/test-utils'

describe('SubmissionForm', () => {
  let wrapper: VueWrapper

  beforeEach(async () => {
    wrapper = await mountSuspended(NewSubmissionPage)
  })

  it('should disable submit button when form is untouched', async () => {
    await flushPromises()

    const submitButton = wrapper.find('button[type="submit"]')
    expect(submitButton.attributes('disabled')).toBeDefined()
  })

  it('should enable submit button when form is modified', async () => {
    await flushPromises()

    const submitButton = wrapper.find('button[type="submit"]')
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
      const titleInput = wrapper.get('input[name="title"]')
      const descriptionTextarea = wrapper.get('textarea[name="description"]')
      const genreSelect = wrapper.getComponent({ name: 'USelect' })
      const versionInput = wrapper.get('input[name="version"]')
      const platformCheckboxes = wrapper.getComponent({
        name: 'UCheckboxGroup',
      })
      const demoUrlInput = wrapper.get('input[name="demo_url"]')
      const form = wrapper.get('form')

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

      expect(wrapper.findAll('em').length).toBe(0)
    })

    it('should not accept insecure links', async () => {
      const demoLinkInput = wrapper.get('input[name="demo_url"]')
      const form = wrapper.get('form')
      await demoLinkInput.setValue('http://example.com')

      await form.trigger('submit')

      const errors = wrapper.findAll('em')
      const errorTexts = errors.map((e) => e.text())
      expect(errorTexts).toContain(
        'Please provide only save URLs starting with https',
      )
    })
  })
})
