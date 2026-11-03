import { mount } from '@vue/test-utils'
import { describe, expect, it } from 'vitest'
import SubmissionsTable from '~/pages/dev/dashboard/submissions/SubmissionsTable.vue'
import type { Submission } from '~/types/Submission'

const submissions: Submission[] = [
  {
    s_id: 'submission-id',
    title: 'Game Title',
    description: 'A game description',
    demo_url: 'https://example.com/demo',
    status: 'prep',
    version: '1.0.0',
    genres: [{ id: '1', name: 'action' }],
    platforms: [{ id: '1', name: 'windows' }],
    created_at: '2026-11-03T20:00:00.000Z',
  },
  {
    s_id: 'another-submission-id',
    title: 'Another Game',
    description: 'Another game description',
    demo_url: 'https://example.com/another-demo',
    status: 'live',
    version: '2.1.0',
    genres: [{ id: '2', name: 'adventure' }],
    platforms: [{ id: '2', name: 'mac' }],
    created_at: '2026-11-02T18:30:00.000Z',
  },
]

describe('SubmissionsTable', () => {
  describe('when no submissions exist', () => {
    it('should say: no data', () => {
      const wrapper = mount(SubmissionsTable, {
        props: {
          submissions: [],
          loadingSubmissions: false,
        },
      })

      const tableDataElements = wrapper.findAll('td')
      const rowValues = tableDataElements.map((data) => data.text())

      expect(rowValues.length).toBe(1)
      expect(rowValues).toContain('No Submissions found.')
    })
  })

  it('should list submissions', () => {
    const wrapper = mount(SubmissionsTable, {
      props: {
        submissions,
        loadingSubmissions: false,
      },
    })

    const renderedText = wrapper.text()

    submissions.forEach(({ title, status, version }) => {
      expect(renderedText).toContain(title)
      expect(renderedText).toContain(status)
      expect(renderedText).toContain(version)
    })
  })
})
