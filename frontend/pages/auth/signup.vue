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
              >{{ error }}</em
            >
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
              @blur="field.handleBlur"
            />
          </template>
        </form.Field>
      </div>

      <div class="flex flex-col gap-1">
        <form.Field name="passwordConfirmation">
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
      // Do something with form data
      alert(JSON.stringify(value))
    },
    defaultValues: {
      email: '',
      password: '',
      passwordConfirmation: '',
    },
  })

  function validateEmail(value: string) {
    const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/
    if (value && !emailRegex.test(value)) {
      return 'Please provide a valid email address'
    }
    if (value === '') {
      return 'Email is required'
    }
  }
</script>
