import { mount } from '@vue/test-utils'
import { describe, expect, it } from 'vitest'
import SubmissionsTable from '~/pages/dashboard/submissions/SubmissionsTable.vue'

// const submissions: Submission[] = [
//   {
//     s_id: '123456789',
//     title: 'A Game',
//     description: '',
//     demo_url: '',
//     status: 'in_review',
//     version: '1',
//     genre: ['action'],
//     platforms: ['windows'],
//     created_at: 'Mar 22, 22:16',
//   },
// ]

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
})
