import { describe, it, expect, vi, beforeEach } from 'vitest'
import { mountSuspended } from '@nuxt/test-utils/runtime'
import { VueWrapper } from '@vue/test-utils'
import SubmissionsPage from '~/pages/dashboard/submissions/index.vue'
import { UButton } from '#components'
import SubmissionsTable from '~/pages/dashboard/submissions/SubmissionsTable.vue'

vi.mock('~/composables/useSubmissionsList', () => ({
  useSubmissionsList: () => ({
    data: ref([
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
    ]),
    pending: ref(false),
  }),
}))

describe('SubmissionsPage', () => {
  let wrapper: VueWrapper

  beforeEach(async () => {
    wrapper = await mountSuspended(SubmissionsPage)
  })

  it('should have a heading', async () => {
    const heading = wrapper.find('h2')
    expect(heading.exists()).toBe(true)
    expect(heading.text()).toBe('Your Submissions')
  })

  it('should render in a section tag', async () => {
    const section = wrapper.find('section[data-test-id="submissions-overview"]')
    expect(section.exists()).toBe(true)
  })

  it('should render a create submission button', async () => {
    const button = wrapper.findComponent(UButton)
    console.log(button.html())

    expect(button.exists()).toBe(true)
    expect(button.text()).toBe('Create New Submission')
    expect(button.html()).toContain('href="/submissions/new/"')
  })

  it('should render the SubmissionsTable with correct props', async () => {
    const table = wrapper.findComponent(SubmissionsTable)

    expect(table.exists()).toBe(true)
    expect(table.props('submissions')).toEqual([
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
    ])
  })
})
