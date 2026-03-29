import type { ApiResponse } from './Api'

export interface Submission {
  title: string
  description: string
  demo_url: string
  status: string
  version: string
  genre: string[]
  platforms: string[]
  created_at: string
}

interface CreateSubmissionResult {
  message?: string
}

export type CreateSubmissionResponse = ApiResponse<CreateSubmissionResult>

export type GetSubmissionsListResponse = ApiResponse<Submission[]>

export interface SubmissionConstants {
  platforms: string[]
  genres: string[]
}
