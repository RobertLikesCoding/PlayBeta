import { mount } from '@vue/test-utils'
import { describe, expect, it } from 'vitest'
import { defineComponent, h } from 'vue'
import SubmissionStatusChangeModal from '~/components/SubmissionStatusChangeModal.vue'
import {
  ALLOWED_STATUS_TRANSITIONS,
  type SubmissionStatus,
} from '~/types/Submission'

function createWrapper(status: SubmissionStatus) {
  return mount(SubmissionStatusChangeModal, {
    props: {
      submissionStatus: status,
      loading: false,
    },
    global: {
      stubs: {
        UModal: defineComponent({
          setup(_, { slots }) {
            return () =>
              h('div', [slots.default?.(), slots.body?.(), slots.footer?.()])
          },
        }),
      },
    },
  })
}

describe('SubmissionStatusChangeModal', () => {
  it.each(Object.keys(ALLOWED_STATUS_TRANSITIONS) as SubmissionStatus[])(
    'offers the allowed transitions from "%s"',
    (status) => {
      const wrapper = createWrapper(status)
      const selector = wrapper.getComponent({ name: 'USelect' })
      const expectedOptions = ALLOWED_STATUS_TRANSITIONS[status]

      expect(selector.props('items')).toEqual(expectedOptions)
    },
  )

  it('disables the change-status button when the submission is completed', () => {
    const wrapper = createWrapper('completed')

    expect(wrapper.find('button').attributes('disabled')).toBeDefined()
  })

  it('emits the selected status when submitted', async () => {
    const wrapper = createWrapper('live')
    const selector = wrapper.getComponent({ name: 'USelect' })

    await selector.vm.$emit('update:modelValue', 'completed')
    await wrapper.findAll('button').at(-1)?.trigger('click')

    expect(wrapper.emitted('selectedStatus')).toEqual([['completed']])
  })
})
