export function validateEmail(value: string | undefined): string | undefined {
  const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/

  if (!value?.trim()) {
    return 'Email is required'
  }
  if (!emailRegex.test(value)) {
    return 'Please provide a valid email address'
  }
}

export function validatePassword(
  value: string | undefined,
): string | undefined {
  if (!value?.trim()) {
    return 'Password is required'
  }

  validatePasswordLength(value)
}

export function validatePasswordConfirm(
  value: string,
  password: string,
): string | undefined {
  if (!value.trim()) {
    return 'Please confirm your password'
  }
  if (value && value !== password) {
    return "Passwords don't match"
  }
}

export function validateBirthday(
  value: string | undefined,
): string | undefined {
  if (!value) return 'Please enter your birthdate'

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
  return !value?.trim() && 'Please fill in your current password'
}

export function validateNewPassword(value: string | undefined) {
  if (!value?.trim()) return 'Please fill in a new password'
  return validatePasswordLength(value)
}

export function validateNewPasswordConfirm(
  newPassword: string,
  confirmPassword: string,
) {
  if (!confirmPassword.trim()) return 'Please confirm your new password'
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

function validatePasswordLength(value: string, minLength: number = 8) {
  if (value.length < minLength)
    return `Password must be at least ${minLength} characters`
}
