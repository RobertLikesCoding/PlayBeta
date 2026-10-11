import type { ApiResponse } from './Api'

export interface GameDeveloperAPI {
  id: number
  email: string
  bio: string
  website: string
  location: string
  studio_name: string
  avatar: string
}

export type UpdateGameDeveloperResponse = ApiResponse<GameDeveloperAPI>
