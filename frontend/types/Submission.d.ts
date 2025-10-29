export interface SubmissionResponse {
  message?: string
  errors?: string[]
}

export interface SubmissionFormValues {
  title: string
  description: string
  genre: string
  platforms: string
  demo_url: string
  status: string
  version: string
  screenshots: File[]
}
