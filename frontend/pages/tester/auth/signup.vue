<template>
  <SignUpForm
    mode="tester"
    info-text="By signing up, you create an account an can start getting invititations to game demos"
  />
</template>

<script setup lang="ts">
  import { useForm } from '@tanstack/vue-form'
  import SignUpForm from '~/components/common/SignUpForm.vue'
  // this is for setting the layout for the auth pages seperatly from the default layout
  definePageMeta({
    layout: 'auth',
    middleware: ['redirect-if-auth'],
  })

  const { setTokenCookie } = useAuth()

  const signupErrors = ref<string[]>([])

  type SignUpResponse =
    { user_id: number; token: string } | { errors: string[] }

  const form = useForm({
    onSubmit: async ({ value }) => {
      signupErrors.value = []
      try {
        const response: SignUpResponse = await $fetch(
          '/api/v1/game_developers',
          {
            baseURL: useRuntimeConfig().public.apiBase,
            method: 'POST',
            headers: {
              'Content-Type': 'application/json',
            },
            body: {
              game_developer: {
                email: value.email,
                password: value.password,
                password_confirmation: value.password_confirmation,
              },
            },
            throw: false,
          },
        )

        form.reset()
        if ('token' in response) {
          setTokenCookie(response.token)
          navigateTo('/dev/dashboard/submissions')
        }
      } catch (error) {
        const errors = error as { data?: { errors?: string[] } }
        const apiErrors = errors.data?.errors

        signupErrors.value =
          Array.isArray(apiErrors) && apiErrors.length > 0
            ? apiErrors
            : ['An unexpected error occurred. Please try again.']

        console.error(error)
      }
    },
    defaultValues: {
      email: '',
      password: '',
      password_confirmation: '',
    },
  })

  function validateEmail(value: string): string | undefined {
    const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/

    if (value && !emailRegex.test(value)) {
      return 'Please provide a valid email address'
    }
    if (value === '') {
      return 'Email is required'
    }
    return undefined
  }

  function validatePassword(value: string): string | undefined {
    if (value && value.length < 8) {
      return 'Minimum length is 8 characters'
    }
    if (value.length === 0) {
      return 'Password is required'
    }
    return undefined
  }

  function validatePasswordConfirm(value: string): string | undefined {
    if (value && value !== form.getFieldValue('password')) {
      return "Passwords don't match"
    }
    if (value.length === 0) {
      return 'Please confirm your password'
    }
    return undefined
  }
</script>
