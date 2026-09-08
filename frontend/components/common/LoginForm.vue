<template>
  <div class="max-w-md w-full px-4">
    <h1 class="text-3xl font-semibold mb-8 text-center">
      Sign in to your account
    </h1>

    <form
      class="flex-col gap-4 flex"
      @submit.prevent="form.handleSubmit()"
    >
      <div class="flex flex-col gap-1">
        <form.Field name="email">
          <template #default="{ field, state }">
            <label :htmlFor="field.name">Email</label>
            <UInput
              :id="field.name"
              :name="field.name"
              type="email"
              :value="field.state.value"
              trailing-icon="i-lucide-at-sign"
              variant="subtle"
              @input="
                (e: Event) =>
                  field.handleChange((e.target as HTMLInputElement).value)
              "
            />
            <em
              v-for="(error, index) of state.meta.errors"
              :key="index"
              class="text-red-300"
              role="alert"
              >{{ error }}
            </em>
          </template>
        </form.Field>
      </div>

      <div class="flex flex-col gap-1">
        <form.Field name="password">
          <template #default="{ field, state }">
            <label :htmlFor="field.name">Password</label>
            <UInput
              :id="field.name"
              :name="field.name"
              type="password"
              :value="field.state.value"
              trailing-icon="lucide:lock-keyhole"
              variant="subtle"
              @input="
                (e: Event) =>
                  field.handleChange((e.target as HTMLInputElement).value)
              "
            />
            <em
              v-for="(error, index) of state.meta.errors"
              :key="index"
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
        :loading="form.useSelector((meta) => meta.isSubmitting).value"
        :disabled="form.useSelector((meta) => meta.isSubmitting).value"
      />
    </form>
    <div
      v-if="
        form.useSelector((meta) => meta.isSubmitted).value &&
        !signInErrors.length
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
          v-for="(error, index) in signInErrors"
          :key="index"
          class="list-inside"
        >
          {{ error }}
        </li>
      </ul>
    </div>
    <p class="text-center pt-10">
      Don't have an account yet?
      <NuxtLink
        :to="isDev ? '/dev/auth/signup' : '/tester/auth/signup'"
        class="text-primary cursor-pointer hover:text-primary-300"
        >Sign up</NuxtLink
      >
    </p>
  </div>
</template>

<script setup lang="ts">
  import { useForm } from '@tanstack/vue-form'
  import { useAuth } from '#imports'

  const props = defineProps<{
    mode: 'dev' | 'tester'
    infoText: string
  }>()

  const isDev = props.mode === 'dev'
  const { setTokenCookie } = useAuth()

  const signInErrors = ref<string[]>([])

  type SignInResponse =
    { user_id: number; token: string } | { errors: string[] }

  const form = useForm({
    onSubmit: async ({ value }) => {
      signInErrors.value = []
      const requestPath = isDev
        ? '/api/v1/auth/developer_login'
        : '/api/v1/auth/tester_login'

      const redirectPath = isDev
        ? '/dev/dashboard/submissions'
        : '/tester/dashboard'
      try {
        const response: SignInResponse = await $fetch(requestPath, {
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
          setTokenCookie(response.token)
          navigateTo(redirectPath)
        }
      } catch (error) {
        const errors = error as { data?: { errors?: string[] } }
        const apiErrors = errors.data?.errors

        signInErrors.value =
          Array.isArray(apiErrors) && apiErrors.length > 0
            ? apiErrors
            : ['An unexpected error occurred. Please try again.']

        console.error(error)
      }
    },
    defaultValues: {
      email: '',
      password: '',
    },
  })
</script>
