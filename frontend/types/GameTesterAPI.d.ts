export interface GameTesterAPI {
  id: number
  email: string
  birthdate: string
  gender: 'prefer_not_to_say' | 'male' | 'female' | 'non_binary'
}
