import { shallowMount } from '@vue/test-utils'
import { describe, expect, it } from 'vitest'
import SubmissionForm from '~/components/SubmissionForm.vue'
import NewSubmissionPage from '~/pages/dashboard/submissions/new.vue'

describe('Submission New Page', () => {
  it('should render the SubmissionForm', () => {
    const wrapper = shallowMount(NewSubmissionPage)
    const form = wrapper.getComponent(SubmissionForm)

    expect(form.props('mode')).toBe('create')
  })
})
