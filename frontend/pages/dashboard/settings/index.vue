<template>
  <div>
    <form
      @submit.prevent="form.handleSubmit()"
      class="flex flex-col gap-5"
    >
      <section
        class="bg-neutral-700/20 rounded p-5 flex flex-col gap-4"
        data-test-id="password-section"
      >
        <h3 class="text-2xl font-bold">Set new password</h3>
        <div class="flex flex-col gap-2">
          <form.Field name="current_password">
            <template v-slot="{ field, state }">
              <label :htmlFor="field.name">Current Password</label>
              <UInput
                :id="field.name"
                :name="field.name"
                type="password"
                :value="field.state.value"
                variant="outline"
                @input="
                  (e: Event) =>
                    field.handleChange((e.target as HTMLInputElement).value)
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

        <div class="flex flex-col gap-2">
          <form.Field name="new_password">
            <template v-slot="{ field, state }">
              <label :htmlFor="field.name">New Password</label>
              <UInput
                :id="field.name"
                :name="field.name"
                type="password"
                :value="field.state.value"
                variant="outline"
                @input="
                  (e: Event) =>
                    field.handleChange((e.target as HTMLInputElement).value)
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

        <div class="flex flex-col gap-2">
          <form.Field name="new_password_confirmation">
            <template v-slot="{ field, state }">
              <label :htmlFor="field.name">Confirm Your New Password</label>
              <UInput
                :id="field.name"
                :name="field.name"
                type="password"
                :value="field.state.value"
                variant="outline"
                @input="
                  (e: Event) =>
                    field.handleChange((e.target as HTMLInputElement).value)
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
      </section>

      <form.Subscribe>
        <template v-slot="{ canSubmit, isSubmitting, isSubmitted, isTouched }">
          <UButton
            type="submit"
            class="justify-center hover:cursor-pointer w-full mb-5"
            size="xl"
            :label="
              isSubmitted && !isTouched ? 'Changes saved!' : 'Save changes'
            "
            :loading="form.useStore((meta) => meta.isSubmitting).value"
            :disabled="isSubmitting || !canSubmit || !isTouched"
          />
        </template>
      </form.Subscribe>
    </form>
  </div>
</template>

<script setup lang="ts">
  import { useForm } from '@tanstack/vue-form'
  import type {
    GameDeveloperAPI,
    UpdateGameDeveloperResponse,
  } from '~/types/GameDeveloper'

  definePageMeta({
    layout: 'dashboard',
  })

  const props = defineProps<{
    user: GameDeveloperAPI | null
    isLoading: boolean
  }>()

  const { token } = useAuth()

  const toast = useToast()

  const form = useForm({
    onSubmit: async ({ value }) => {
      try {
        const response: UpdateGameDeveloperResponse = await $fetch(
          `/api/v1/passwords/update`,
          {
            baseURL: useRuntimeConfig().public.apiBase,
            method: 'PATCH',
            headers: {
              'Content-Type': 'application/json',
              Authorization: `Bearer ${token.value}`,
            },
            body: {
              password_changes: {
                current_password: value.current_password,
                new_password: value.new_password,
                new_password_confirmation: value.new_password_confirmation,
              },
            },
          },
        )
        if (response && response.errors) {
          console.error('Update failed:', response.errors)
          toast.add({
            title: 'Error',
            description: 'Saving failed. Please try again',
            color: 'error',
            icon: 'i-lucide-x-circle',
          })
        } else {
          form.reset({
            current_password: '',
            new_password: '',
            new_password_confirmation: '',
          })

          toast.add({
            title: 'Success',
            description: 'Your changes were saved successfully.',
            color: 'success',
            icon: 'i-lucide-check-circle',
          })
          return response
        }
      } catch (error) {
        console.error('An unexpected error occurred:', error)
      }
    },
    defaultValues: {
      current_password: '',
      new_password: '',
      new_password_confirmation: '',
    },
    validators: {
      onSubmit: ({ value }) => ({
        fields: {
          current_password: validateCurrentPassword(value.current_password),
          new_password: validateNewPassword(value.new_password),
          new_password_confirmation: validateNewPasswordConfirm(
            value.new_password,
            value.new_password_confirmation,
          ),
        },
      }),
    },
  })

  function validateCurrentPassword(value: string) {
    !value ? 'Please fill in your current password' : undefined
  }

  function validateNewPassword(value: string) {
    if (!value) return 'Please fill in a new password'
    if (value.length < 8) return 'Password must be at least 8 characters'
    return undefined
  }

  function validateNewPasswordConfirm(
    newPassword: string,
    confirmPassword: string,
  ) {
    if (!confirmPassword) return 'Please confirm your new password'
    if (newPassword !== confirmPassword) return 'Passwords do not match'
    return undefined
  }
</script>
