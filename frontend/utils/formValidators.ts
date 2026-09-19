export function validateEmail(value: string): string | undefined {
  const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/

  if (value && !emailRegex.test(value)) {
    return 'Please provide a valid email address'
  }
  if (value === '') {
    return 'Email is required'
  }
}

export function validatePassword(value: string): string | undefined {
  validatePasswordLength(value)

  if (value.length === 0) {
    return 'Password is required'
  }
}

export function validatePasswordConfirm(
  value: string,
  password: string,
): string | undefined {
  if (value && value !== password) {
    return "Passwords don't match"
  }
  if (value.length === 0) {
    return 'Please confirm your password'
  }
}

export function validateBirthday(value: string): string | undefined {
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

export function validateCurrentPassword(value: string) {
  return !value ? 'Please fill in your current password' : undefined
}

export function validateNewPassword(value: string) {
  if (!value) return 'Please fill in a new password'
  return validatePasswordLength(value)
}

export function validateNewPasswordConfirm(
  newPassword: string,
  confirmPassword: string,
) {
  if (!confirmPassword) return 'Please confirm your new password'
  if (newPassword !== confirmPassword) return 'Passwords do not match'
}

function validatePasswordLength(value: string, minLength: number = 8) {
  if (value.length < minLength)
    return `Password must be at least ${minLength} characters`
}
