<template>
  <div class="max-w-md px-4">
    <h1 class="text-3xl font-semibold mb-8 text-center">Create an account</h1>
    <p class="pb-5">
      By signing up, you can upload your demos, connect with dedicated
      playtesters, and gather insights to improve your game.
    </p>

    <form
      @submit.prevent="form.handleSubmit()"
      class="flex-col gap-4 flex"
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
                (e: Event) =>
                  field.handleChange((e.target as HTMLInputElement).value)
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
                (e: Event) =>
                  field.handleChange((e.target as HTMLInputElement).value)
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
                (e: Event) =>
                  field.handleChange((e.target as HTMLInputElement).value)
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
        class="mt-2 justify-center hover:cursor-pointer"
        size="xl"
        label="Submit"
        :loading="form.useStore((meta) => meta.isSubmitting).value"
        :disabled="form.useStore((meta) => meta.isSubmitting).value"
      />
    </form>
    <div
      v-if="
        form.useStore((meta) => meta.isSubmitted).value && !signupErrors.length
      "
      class="border-2 rounded-md mt-5 p-2 border-green-300"
    >
      <p>
        Sign Up was successful. We've sent you an activation link to your inbox
      </p>
    </div>
    <div
      v-if="signupErrors.length"
      class="border-2 rounded-md mt-5 p-2 border-red-400"
    >
      <p>Sign Up failed because:</p>
      <ul>
        <li
          v-for="error in signupErrors"
          key="error"
          class="list-disc list-inside"
        >
          {{ error }}
        </li>
      </ul>
    </div>
    <p class="text-center pt-10">
      Already have an account?
      <NuxtLink
        to="/auth/login"
        class="text-primary cursor-pointer hover:text-primary-300"
        >Sign in</NuxtLink
      >
    </p>
  </div>
</template>

<script setup lang="ts">
  import { useForm } from '@tanstack/vue-form'
  // this is for setting the layout for the auth pages seperatly from the default layout
  definePageMeta({
    layout: 'auth',
    middleware: ['redirect-if-auth'],
  })

  const { setToken } = useAuth()

  const signupErrors = ref<string[]>([])

  type SignUpResponse =
    | { user_id: number; token: string }
    | { errors: string[] }

  const form = useForm({
    onSubmit: async ({ value }) => {
      signupErrors.value = []
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
                password_confirmation: value.password_confirmation,
              },
            },
            throw: false,
          },
        )

        form.reset()
        if ('token' in response) {
          setToken(response.token)
          navigateTo('/dashboard/submissions')
        }
      } catch (error) {
        // @ts-expect-error
        if (error?.data.errors) {
          // @ts-expect-error
          signupErrors.value = error.data.errors
        } else {
          signupErrors.value = [
            'An unexpected error occurred. Please try again.',
          ]
        }
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
