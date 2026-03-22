export type ApiSuccess<T> = {
  success: true
  data: T
  message?: string
}

export type ApiError = {
  success: false
  errors: string[]
  message?: string
}

export type ApiResponse<T> = ApiSuccess<T> | ApiError
