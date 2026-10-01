import { describe, expect, it } from 'vitest'
import {
  PRESENCE_ERROR,
  validateBirthday,
  validateCurrentPassword,
  validateDemoUrl,
  validateEmail,
  validateNewPassword,
  validateNewPasswordConfirm,
  validatePassword,
  validatePasswordConfirm,
  validateUrl,
} from '../utils/formValidators'

describe('formValidators', () => {
  describe('validateEmail', () => {
    it('returns undefined for a valid email', () => {
      const mail = 'test.account@example.com'

      const result = validateEmail(mail)
      expect(result).toBeUndefined()
    })

    it('returns error message for invalid mail', () => {
      const mail = 'test#account.de'

      const result = validateEmail(mail)
      expect(result).toContain('Please provide a valid email address')
    })

    it('returns error message for missing value', () => {
      const mail = ' '

      const result = validateEmail(mail)
      expect(result).toEqual(PRESENCE_ERROR)
    })
  })

  describe('validatePassword', () => {
    it('returns undefined for a valid password', () => {
      const password = 'Password123!'

      const result = validatePassword(password)
      expect(result).toBeUndefined()
    })

    it('returns error message for short password', () => {
      const password = '111111'

      const result = validatePassword(password)
      expect(result).toContain('Password must be at least')
    })

    it('returns error message for missing value', () => {
      const password = ' '

      const result = validatePassword(password)
      expect(result).toEqual(PRESENCE_ERROR)
    })
  })

  describe('validatePasswordConfirm', () => {
    it('returns undefined when passwords match', () => {
      const result = validatePasswordConfirm('Password123!', 'Password123!')
      expect(result).toBeUndefined()
    })

    it('returns mismatch error when passwords differ', () => {
      const result = validatePasswordConfirm('Password123!', 'Password456!')
      expect(result).toBe("Passwords don't match")
    })

    it('returns presence error for missing value', () => {
      const result = validatePasswordConfirm(' ', 'Password123!')
      expect(result).toEqual(PRESENCE_ERROR)
    })
  })

  describe('validateBirthday', () => {
    it('returns undefined when the tester is old enough', () => {
      const result = validateBirthday('2000-01-01')
      expect(result).toBeUndefined()
    })

    it('returns minimum age error for underage tester', () => {
      const result = validateBirthday('2015-01-01')
      expect(result).toContain('at least 16')
    })

    it('returns presence error for missing value', () => {
      const result = validateBirthday(' ')
      expect(result).toEqual(PRESENCE_ERROR)
    })
  })

  describe('validateCurrentPassword', () => {
    it('returns undefined for a valid current password', () => {
      const result = validateCurrentPassword('CurrentPass1!')
      expect(result).toBeUndefined()
    })

    it('returns presence error for missing value', () => {
      const result = validateCurrentPassword(' ')
      expect(result).toEqual(PRESENCE_ERROR)
    })
  })

  describe('validateNewPassword', () => {
    it('returns undefined for a long enough password', () => {
      const result = validateNewPassword('NewPass123!')
      expect(result).toBeUndefined()
    })

    it('returns error message for short password', () => {
      const result = validateNewPassword('1234567')
      expect(result).toContain('Password must be at least 8')
    })

    it('returns presence error for missing value', () => {
      const result = validateNewPassword(' ')
      expect(result).toEqual(PRESENCE_ERROR)
    })
  })

  describe('validateNewPasswordConfirm', () => {
    it('returns undefined when new passwords match', () => {
      const result = validateNewPasswordConfirm('NewPass123!', 'NewPass123!')
      expect(result).toBeUndefined()
    })

    it('returns mismatch error when new passwords differ', () => {
      const result = validateNewPasswordConfirm('NewPass123!', 'NewPass456!')
      expect(result).toBe('Passwords do not match')
    })

    it('returns presence error for missing confirmation', () => {
      const result = validateNewPasswordConfirm('NewPass123!', ' ')
      expect(result).toEqual(PRESENCE_ERROR)
    })
  })

  describe('validateUrl', () => {
    it('returns undefined for a valid https URL', () => {
      const result = validateUrl('https://example.com')
      expect(result).toBeUndefined()
    })

    it('returns error for non-https URLs', () => {
      const result = validateUrl('http://example.com')
      expect(result).toBe('Please provide only save URLs starting with https')
    })

    it('returns error for malformed URLs', () => {
      const result = validateUrl('not-a-valid-url')
      expect(result).toBe('Please provide a valid URL')
    })

    it('returns undefined for blank input', () => {
      const result = validateUrl(' ')
      expect(result).toBeUndefined()
    })
  })

  describe('validateDemoUrl', () => {
    it('returns undefined for a valid demo URL', () => {
      const result = validateDemoUrl('https://example.com/demo')
      expect(result).toBeUndefined()
    })

    it('returns presence error for missing value', () => {
      const result = validateDemoUrl(' ')
      expect(result).toEqual(PRESENCE_ERROR)
    })

    it('returns error for non-https URLs', () => {
      const result = validateDemoUrl('http://example.com/demo')
      expect(result).toBe('Please provide only save URLs starting with https')
    })
  })
})
