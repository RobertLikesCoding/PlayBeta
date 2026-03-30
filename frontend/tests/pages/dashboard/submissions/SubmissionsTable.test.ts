import { describe, it, expect, vi, beforeEach } from 'vitest'
import { mountSuspended } from '@nuxt/test-utils/runtime'
import { VueWrapper } from '@vue/test-utils'
import SubmissionsTable from '~/pages/dashboard/submissions/SubmissionsTable.vue'
import type { Submission } from '~/types/Submission'

const submissions: Submission[] = [
  {
    title: 'A Game',
    description: '',
    demo_url: '',
    status: 'in_review',
    version: '1',
    genre: ['action'],
    platforms: ['windows'],
    created_at: 'Mar 22, 22:16',
  },
]

describe('SubmissionsTable', () => {
  let wrapper: VueWrapper

  beforeEach(async () => {
    wrapper = await mountSuspended(SubmissionsTable, {
      props: {
        submissions,
        loadingSubmissions: false,
      },
    })
  })

  describe('table headers', () => {
    let columnTitles: string[] = []
    beforeEach(() => {
      const columns = wrapper.findAll('th')
      columnTitles = columns.map((col) => {
        return col.text()
      })
    })
    it('should have a Title column', async () => {
      expect(columnTitles).toContain('Title')
    })
    it('should have a Status column', () => {
      expect(columnTitles).toContain('Status')
    })
    it('should have a Verison column', () => {
      expect(columnTitles).toContain('Version')
    })
    it('should have a completed column', () => {
      expect(columnTitles).toContain('Created at')
    })
  })

  describe('when no submissions exist', () => {
    it('should say: no data', async () => {
      wrapper = await mountSuspended(SubmissionsTable, {
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

  describe('a row', () => {
    let rowValues: string[] = []
    beforeEach(() => {
      const tableDataElements = wrapper.findAll('td')
      rowValues = tableDataElements.map((data) => data.text())
    })
    it('should display the title of a submission', async () => {
      expect(rowValues).toContain('A Game')
    })
    it('should display the status of a submission', async () => {
      expect(rowValues).toContain('in_review')
    })
    it('should display the version of a submission', async () => {
      expect(rowValues).toContain('1')
    })
    it('should display the creation date of a submission', async () => {
      expect(rowValues).toContain('Mar 22, 22:16')
    })

    it('should open a detail page when clicked', async () => {})
  })
})
