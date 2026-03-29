export type ApiSuccess<T> = {
  data: T
  message?: string
}

export type ApiError = {
  errors: string[]
  message?: string
}

export type ApiResponse<T> = ApiSuccess<T> | ApiError
