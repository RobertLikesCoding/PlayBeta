export interface GameTesterAPI {
  id: number
  email: string
  birthdate: string
  gender?: Gender
  username?: string
}

export interface UpdateGameTesterResponse {
  message?: string
  errors?: string[]
}

export const ALLOWED_GENDER_OPTIONS = [
  'prefer_not_to_say',
  'male',
  'female',
  'non_binary',
] as const

export type Gender = (typeof ALLOWED_GENDER_OPTIONS)[number]
