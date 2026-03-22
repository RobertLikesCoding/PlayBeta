import { describe, it, expect, vi, beforeEach } from 'vitest'
import { mountSuspended } from '@nuxt/test-utils/runtime'
import { flushPromises, VueWrapper } from '@vue/test-utils'
import SubmissionsTable from '~/pages/dashboard/submissions/SubmissionsTable.vue'

describe('SubmissionsTable', () => {
  let wrapper: VueWrapper

  beforeEach(async () => {
    wrapper = await mountSuspended(SubmissionsTable)
  })

  it('should render in a section', async () => {
    const section = wrapper.find('section[data-test-id="submissions-overview"]')
    expect(section.exists).toBe(true)
  })

  it('should have a heading', async () => {
    const heading = wrapper.find('h2')
    expect(heading.exists()).toBe(true)
    expect(heading.text()).toBe('Your Submissions')
  })

  it('should have a title column', () => {})
  it('should have a start column', () => {})
  it('should have a end column', () => {})
  it('should have a completed column', () => {})
  it('should have a testers column', () => {})
  it('should have a status column', () => {})

  describe('a column', () => {
    it('should open a detail page when clicked', async () => {})
  })
})
