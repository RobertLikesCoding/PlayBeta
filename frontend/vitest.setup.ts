import { vi } from 'vitest'

vi.mock('~/composables/useAuth', () => ({
  useAuth: () => ({
    isAuthenticated: true,
    token: 'test-token',
    setToken: vi.fn(),
    clearToken: vi.fn(),
  }),
}))
