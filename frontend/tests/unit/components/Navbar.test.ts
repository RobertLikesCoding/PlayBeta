import { describe, it, expect } from 'vitest'
import { mountSuspended } from '@nuxt/test-utils/runtime'
import Navbar from '~/components/Navbar.vue'

describe('Navbar Desktop', () => {
  it('renders the brand name', async () => {
    const wrapper = await mountSuspended(Navbar)
    expect(wrapper.text()).toContain('PlayBeta')
  })

  it('renders 3 navbar items', async () => {
    const wrapper = await mountSuspended(Navbar)

    const desktopItems = wrapper.find('.hidden')
    expect(desktopItems.findAll('a').length).toEqual(3)
  })
})
