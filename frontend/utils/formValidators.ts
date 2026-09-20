export const PRESENCE_ERROR = 'Please fill in this field'

export function validateEmail(value: string | undefined): string | undefined {
  const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/

  if (!value?.trim()) return PRESENCE_ERROR
  if (!emailRegex.test(value)) {
    return 'Please provide a valid email address'
  }
}

export function validatePassword(
  value: string | undefined,
): string | undefined {
  if (!value?.trim()) return PRESENCE_ERROR

  return validatePasswordLength(value)
}

export function validatePasswordConfirm(
  value: string,
  password: string,
): string | undefined {
  if (!value.trim()) return PRESENCE_ERROR
  if (value && value !== password) {
    return "Passwords don't match"
  }
}

export function validateBirthday(
  value: string | undefined,
): string | undefined {
  if (!value?.trim()) return PRESENCE_ERROR

  const MINIMUM_AGE = 16
  const birthDate = new Date(value)
  const currentDate = new Date()
  let userAge = currentDate.getFullYear() - birthDate.getFullYear()

  if (birthDate.getMonth() > currentDate.getMonth()) {
    userAge = userAge - 1
  } else if (
    birthDate.getMonth() === currentDate.getMonth() &&
    birthDate.getDate() > currentDate.getDate()
  ) {
    userAge = userAge - 1
  }

  if (userAge < MINIMUM_AGE) {
    return `You need to be at least ${MINIMUM_AGE} to sign up as a tester.`
  }
}

export function validateCurrentPassword(value: string | undefined) {
  if (!value?.trim()) return PRESENCE_ERROR
}

export function validateNewPassword(value: string | undefined) {
  if (!value?.trim()) return PRESENCE_ERROR
  return validatePasswordLength(value)
}

export function validateNewPasswordConfirm(
  newPassword: string,
  confirmPassword: string,
) {
  if (!confirmPassword.trim()) return PRESENCE_ERROR
  if (newPassword !== confirmPassword) return 'Passwords do not match'
}

export function validateUrl(value: string | undefined) {
  if (!value?.trim()) return

  try {
    const url = new URL(value)
    if (url.protocol !== 'https:') {
      return 'Please provide only save URLs starting with https'
    }

    return
  } catch (error) {
    return 'Please provide a valid URL'
  }
}

export function validateDemoUrl(value: string) {
  if (!value.trim()) return PRESENCE_ERROR

  return validateUrl(value)
}

function validatePasswordLength(value: string, minLength: number = 8) {
  if (value.length < minLength)
    return `Password must be at least ${minLength} characters`
}
