<template>
  <div class="container mx-auto px-10 max-w-md">
    <h1 class="text-2xl font-bold mb-4">Sign Up</h1>

    <form
      @submit="
        (e) => {
          e.preventDefault()
          form.handleSubmit()
        }
      "
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
          name="passwordConfirmation"
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
      />
    </form>
  </div>
</template>

<script setup lang="ts">
  import { useForm } from '@tanstack/vue-form'
  // this is for setting the layout for the auth pages seperatly from the default layout
  definePageMeta({
    layout: 'auth',
  })

  const form = useForm({
    onSubmit: async ({ value }) => {
      console.log(value)
    },
    defaultValues: {
      email: '',
      password: '',
      passwordConfirmation: '',
    },
  })

  console.log(form.getAllErrors)

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
