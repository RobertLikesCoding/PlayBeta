<template>
  <div class="container mx-auto px-10 max-w-md">
    <h1 class="text-2xl font-bold mb-4">Sign Up</h1>

    <form
      @submit.prevent="form.handleSubmit()"
      class="flex-col gap-3 flex"
    >
      <div class="flex flex-col gap-1">
        <form.Field
          name="email"
          :validators="{
            onBlur: ({ value }) => {
              return validateEmail(value)
            },
          }"
        >
          <template v-slot="{ field, state }">
            <label :htmlFor="field.name">Email</label>
            <UInput
              :name="field.name"
              type="email"
              :value="field.state.value"
              trailing-icon="i-lucide-at-sign"
              variant="subtle"
              @input="
                (e) => field.handleChange((e.target as HTMLInputElement).value)
              "
              @blur="field.handleBlur"
            />
            <em
              v-for="error of state.meta.errors"
              class="text-red-300"
              role="alert"
              >{{ error }}
            </em>
          </template>
        </form.Field>
      </div>

      <div class="flex flex-col gap-1">
        <form.Field
          name="password"
          :validators="{
            onBlur: ({ value }) => {
              return validatePassword(value)
            },
          }"
        >
          <template v-slot="{ field, state }">
            <label :htmlFor="field.name">Password</label>
            <UInput
              :name="field.name"
              type="password"
              :value="field.state.value"
              trailing-icon="lucide:lock-keyhole"
              variant="subtle"
              @input="
                (e) => field.handleChange((e.target as HTMLInputElement).value)
              "
              @blur="field.handleBlur"
            />
            <em
              v-for="error of state.meta.errors"
              class="text-red-300"
              role="alert"
              >{{ error }}
            </em>
          </template>
        </form.Field>
      </div>

      <div class="flex flex-col gap-1">
        <form.Field
          name="password_confirmation"
          :validators="{
            onBlur: ({ value }) => {
              return validatePasswordConfirm(value)
            },
          }"
        >
          <template v-slot="{ field, state }">
            <label :htmlFor="field.name">Password Confirmation</label>
            <UInput
              :name="field.name"
              type="password"
              :value="field.state.value"
              trailing-icon="lucide:lock-keyhole"
              variant="subtle"
              @input="
                (e) => field.handleChange((e.target as HTMLInputElement).value)
              "
              @blur="field.handleBlur"
            />
            <em
              v-for="error of state.meta.errors"
              class="text-red-300"
              role="alert"
              >{{ error }}
            </em>
          </template>
        </form.Field>
      </div>
      <UButton
        type="submit"
        class="mt-4 justify-center"
        size="xl"
        label="Submit"
        :loading="form.useStore((meta) => meta.isSubmitting).value"
        :disabled="form.useStore((meta) => meta.isSubmitting).value"
      />
    </form>
    <div
      v-if="form.useStore((meta) => meta.isSubmitted).value"
      class="border-2 rounded-md mt-5 p-2 border-green-300"
    >
      <p>
        Sign Up was successfull. We've send you an activation link to your inbox
      </p>
    </div>
    <div
      v-if="hasError"
      class="border-2 rounded-md mt-5 p-2 border-red-400"
    >
      <p>Sign Up failed, please try again</p>
    </div>
  </div>
</template>

<script setup lang="ts">
  import { useForm } from '@tanstack/vue-form'
  // this is for setting the layout for the auth pages seperatly from the default layout
  definePageMeta({
    layout: 'auth',
  })

  const hasError = ref(false)

  type SignUpResponse =
    | { user_id: number; token: string }
    | { errors: string[] }

  const form = useForm({
    onSubmit: async ({ value }) => {
      try {
        const response: SignUpResponse = await $fetch(
          '/api/v1/game_developers/signup',
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
                password_confirmation: '123',
              },
            },
          },
        )

        if ('errors' in response) {
          console.error('Sign up failed', response.errors)
        }
        console.log('Sign Up Success', response)
        return response
      } catch (error) {
        hasError.value = true
        console.error(error)
      } finally {
        form.reset()
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
