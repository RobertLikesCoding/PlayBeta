import type { ApiResponse } from './Api'
import type { Genre, Platform } from './misc'

export interface GameTesterAPI {
  id: number
  email: string
  birthdate: string
  gender?: Gender
  username?: string
  genres?: Genre[]
  platforms?: Platform[]
}

export type UpdateGameTesterResponse = ApiResponse<GameTesterAPI>

export const ALLOWED_GENDER_OPTIONS = [
  'prefer_not_to_say',
  'male',
  'female',
  'non_binary',
] as const

export type Gender = (typeof ALLOWED_GENDER_OPTIONS)[number]
