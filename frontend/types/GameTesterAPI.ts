import type { ApiResponse } from './Api'

export interface GameTesterAPI {
  id: number
  email: string
  birthdate: string
  gender?: Gender
  username?: string
}

export type GameTesterCreateResponse = ApiResponse<{
  id: number
  token: string
}>

export type UpdateGameTesterResponse = ApiResponse<GameTesterAPI>

export const ALLOWED_GENDER_OPTIONS = [
  'prefer_not_to_say',
  'male',
  'female',
  'non_binary',
] as const

export type Gender = (typeof ALLOWED_GENDER_OPTIONS)[number]
