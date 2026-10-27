import type { ApiResponse } from './Api'
import type { Genre, Platform } from './misc'

export interface Submission {
  s_id: string
  title: string
  description: string
  demo_url: string
  status: SubmissionStatus
  version: string
  genres: Genre[]
  platforms: Platform[]
  created_at: string
}

export type SubmissionStatus = 'prep' | 'live' | 'closed' | 'completed'

interface CreateSubmissionResult {
  message?: string
  errors: string[]
}

export type CreateSubmissionResponse = ApiResponse<CreateSubmissionResult>

export type GetSubmissionResponse = ApiResponse<Submission>
export type GetSubmissionsListResponse = ApiResponse<Submission[]>

export interface SubmissionConstants {
  platforms: { id: number; name: string }[]
  genres: { id: number; name: string }[]
}
