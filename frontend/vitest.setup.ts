import { vi } from 'vitest'

declare global {
  var submitSpy: ReturnType<typeof vi.fn>
}

globalThis.submitSpy = vi.fn().mockResolvedValue({ success: true })

globalThis.$fetch = vi.fn((url: string) => {
  if (url === '/api/v1/submissions/constants') {
    return Promise.resolve({
      platforms: ['windows', 'mac', 'linux', 'web'],
      genres: ['action', 'adventure', 'puzzle', 'rpg'],
    })
  }
  if (url === '/api/v1/submissions') {
    return globalThis.submitSpy()
  }
  return Promise.resolve({})
}) as any
