export interface GameDeveloperAPI {
  id: number
  email: string
  bio: string
  website: string
  location: string
  studio_name: string
  avatar: string
}

export interface UpdateGameDeveloperResponse {
  message?: string
  errors?: string[]
}
