import { describe, it, expect, vi, beforeEach } from 'vitest'
import { mountSuspended } from '@nuxt/test-utils/runtime'
import { flushPromises, VueWrapper } from '@vue/test-utils'
import SubmissionsPage from '~/pages/dashboard/submissions/index.vue'

describe('SubmissionsPage', () => {
  let wrapper: VueWrapper

  beforeEach(async () => {
    wrapper = await mountSuspended(SubmissionsPage)
  })

  it('should render the SubmissionsTable', async () => {
    const table = wrapper.findComponent('SubmissionsTable')
    expect(table.exists).toBe(true)
  })

  it('should render a create submission button', async () => {
    const button = wrapper.find('a[href="/dashboard/submissions/new/"]')
    expect(button.exists).toBe(true)
  })

  it('should fetch submissions and pass to table component', async () => {})
})
