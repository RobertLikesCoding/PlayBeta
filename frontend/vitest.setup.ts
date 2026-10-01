import { vi } from 'vitest'

declare global {
  var submitSpy: ReturnType<typeof vi.fn>
}

globalThis.submitSpy = vi.fn().mockResolvedValue({ success: true })

globalThis.$fetch = vi.fn((url: string) => {
  if (url === '/api/v1/submissions/constants') {
    return Promise.resolve({
      platforms: [
        { id: 1, name: 'windows' },
        { id: 2, name: 'mac' },
        { id: 3, name: 'linux' },
        { id: 4, name: 'web' },
      ],
      genres: [
        { id: 1, name: 'action' },
        { id: 2, name: 'adventure' },
        { id: 3, name: 'puzzle' },
        { id: 4, name: 'rpg' },
      ],
    })
  }
  if (url === '/api/v1/submissions') {
    return new globalThis.submitSpy()
  }
  return Promise.resolve({})
}) as any
