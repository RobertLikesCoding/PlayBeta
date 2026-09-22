<template>
  <div class="max-w-md px-4">
    <h1 class="text-3xl font-semibold mb-8 text-center">{{ heading }}</h1>
    <p class="pb-5 text-center">
      {{ infoText }}
    </p>

    <form
      class="flex-col gap-4 flex"
      @submit.prevent="form.handleSubmit()"
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
              @blur="field.handleBlur"
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
        <form.Field
          name="password"
          :validators="{
            onBlur: ({ value }) => {
              return validatePassword(value)
            },
          }"
        >
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
              @blur="field.handleBlur"
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
        <form.Field
          name="password_confirmation"
          :validators="{
            onBlur: ({ value }) => {
              return validatePasswordConfirm(
                value,
                form.getFieldValue('password'),
              )
            },
          }"
        >
          <template #default="{ field, state }">
            <label :htmlFor="field.name">Password Confirmation</label>
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
              @blur="field.handleBlur"
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

      <div
        v-if="!isDev"
        class="flex flex-col gap-1"
      >
        <form.Field
          name="birthdate"
          :validators="{
            onBlur: ({ value }) => {
              return validateBirthday(value)
            },
          }"
        >
          <template #default="{ field, state }">
            <label :htmlFor="field.name">Birth Date</label>
            <UInput
              :id="field.name"
              :name="field.name"
              type="date"
              :value="field.state.value"
              variant="subtle"
              @input="
                (e: Event) =>
                  field.handleChange((e.target as HTMLInputElement).value)
              "
              @blur="field.handleBlur"
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
        :disabled="
          form.useSelector((meta) => meta.isSubmitting).value ||
          form.useSelector((meta) => meta.errors.length !== 0).value
        "
      />
    </form>
    <div
      v-if="
        form.useSelector((meta) => meta.isSubmitted).value &&
        !signupErrors.length
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
          v-for="(error, index) in signupErrors"
          :key="index"
          class="list-disc list-inside"
        >
          {{ error }}
        </li>
      </ul>
    </div>
    <p class="text-center pt-10">
      Already have an account?
      <NuxtLink
        :to="isDev ? '/dev/auth/login' : '/tester/auth/login'"
        class="text-primary cursor-pointer hover:text-primary-300"
        >Sign in</NuxtLink
      >
    </p>
  </div>
</template>

<script setup lang="ts">
  import { useForm } from '@tanstack/vue-form'
  import type { AccountType } from '~/types/misc'

  const props = defineProps<{
    accountType: AccountType
    infoText: string
  }>()

  const isDev = computed(() => props.accountType === 'dev')
  const heading = computed(() => {
    return isDev.value
      ? 'Create a Developer account'
      : 'Create a Tester account'
  })

  const { setTokenCookie } = useAuth()
  const signupErrors = ref<string[]>([])

  type SignUpResponse =
    { user_id: number; token: string } | { errors: string[] }

  const form = useForm({
    onSubmit: async ({ value }) => {
      signupErrors.value = []
      const path = isDev.value
        ? '/api/v1/game_developers'
        : '/api/v1/game_testers'

      const redirectPath = isDev.value
        ? '/dev/dashboard/submissions'
        : '/tester/dashboard/profile'

      try {
        const response = await $fetch<SignUpResponse>(path, {
          baseURL: useRuntimeConfig().public.apiBase,
          method: 'POST',
          headers: {
            'Content-Type': 'application/json',
          },
          body: {
            signup_payload: {
              email: value.email,
              password: value.password,
              password_confirmation: value.password_confirmation,
              birthdate: value.birthdate,
            },
          },
        })

        form.reset()
        if ('token' in response) {
          setTokenCookie(response.token, props.accountType)
          navigateTo(redirectPath)
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
      birthdate: '',
      gender: '',
    },
  })
</script>
