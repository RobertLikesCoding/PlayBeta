import { vi } from 'vitest'

vi.mock('~/composables/useAuth', () => ({
  useAuth: () => ({
    isAuthenticated: { value: true },
    token: { value: 'test-token' },
    setToken: vi.fn(),
    clearToken: vi.fn(),
  }),
}))
