import { describe, it, expect, vi, beforeEach } from 'vitest'
import type { VueWrapper } from '@vue/test-utils'
import SubmissionsPage from '~/pages/dashboard/submissions/index.vue'
import SubmissionsTable from '~/pages/dashboard/submissions/SubmissionsTable.vue'

const mockData = [
  {
    title: 'A Game',
    description: '',
    demo_url: '',
    status: '',
    version: '1',
    genre: ['action'],
    platforms: ['windows'],
    created_at: 'Mar 22, 22:16',
  },
]

vi.mock('~/composables/useSubmissionsList', () => ({
  useSubmissionsList: () => ({
    data: mockData,
    pending: false,
  }),
}))

describe('SubmissionsPage', () => {
  let wrapper: VueWrapper

  beforeEach(() => {
    wrapper = shallowMount(SubmissionsPage)
  })

  it('should render the SubmissionsTable with correct props', async () => {
    const table = wrapper.getComponent(SubmissionsTable)

    expect(table.props('submissions')).toEqual(mockData)
  })
})
