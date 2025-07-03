<template>
  <div class="max-w-md w-full px-4">
    <h1 class="text-3xl font-semibold mb-8 text-center">
      Sign in to your account
    </h1>

    <form
      @submit.prevent="form.handleSubmit()"
      class="flex-col gap-4 flex"
    >
      <div class="flex flex-col gap-1">
        <form.Field name="email">
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
        <form.Field name="password">
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
        form.useStore((meta) => meta.isSubmitted).value && !signInErrors.length
      "
      class="border-2 rounded-md mt-5 p-2 border-green-300"
    >
      <p>Successfully Signed In. You're being redirected.</p>
    </div>
    <div
      v-if="signInErrors.length"
      class="border-2 rounded-md mt-5 p-2 border-red-400"
    >
      <ul>
        <li
          v-for="error in signInErrors"
          key="error"
          class="list-inside"
        >
          {{ error }}
        </li>
      </ul>
    </div>
    <p class="text-center pt-10">
      Don't have an account yet?
      <NuxtLink
        to="/auth/signup"
        class="text-primary cursor-pointer hover:text-primary-300"
        >Sign up</NuxtLink
      >
    </p>
  </div>
</template>

<script setup lang="ts">
  import { useForm } from '@tanstack/vue-form'
  import { useAuth } from '#imports'
  definePageMeta({
    // this is for setting the layout for the auth pages seperatly from the default layout
    layout: 'auth',
    middleware: ['redirect-if-auth'],
  })

  const { setToken } = useAuth()

  const signInErrors = ref<string[]>([])

  type SignInResponse =
    | { user_id: number; token: string }
    | { errors: string[] }

  const form = useForm({
    onSubmit: async ({ value }) => {
      signInErrors.value = []
      try {
        const response: SignInResponse = await $fetch('/api/v1/auth/login', {
          baseURL: useRuntimeConfig().public.apiBase,
          method: 'POST',
          headers: {
            'Content-Type': 'application/json',
          },
          body: {
            auth: {
              email: value.email,
              password: value.password,
            },
          },
        })

        form.reset()

        if ('token' in response) {
          setToken(response.token)
          navigateTo('/dashboard/submissions')
        }
      } catch (error) {
        // @ts-expect-error
        if (error?.data.errors) {
          // @ts-expect-error
          signInErrors.value = error.data.errors
        } else {
          signInErrors.value = [
            'An unexpected error occurred. Please try again.',
          ]
        }
        console.error(error)
      }
    },
    defaultValues: {
      email: '',
      password: '',
    },
  })
</script>
