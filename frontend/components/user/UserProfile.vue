<template>
  <div>
    <form
      @submit.prevent="form.handleSubmit()"
      class="flex flex-col gap-5"
    >
      <div class="bg-neutral-700/20 rounded p-5 flex flex-col gap-4">
        <h3 class="text-2xl font-bold">Profile</h3>

        <div class="flex flex-col gap-2">
          <form.Field name="email">
            <template v-slot="{ field, state }">
              <label :htmlFor="field.name">Email</label>
              <UInput
                :name="field.name"
                type="email"
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
          <form.Field name="avatar">
            <template v-slot="{ field, state }">
              <label :htmlFor="field.name">Avatar</label>
              <UInput
                :name="field.name"
                type="file"
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
          <form.Field name="studio_name">
            <template v-slot="{ field, state }">
              <label :htmlFor="field.name">Studio Name</label>
              <UInput
                :name="field.name"
                type="text"
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
          <form.Field name="location">
            <template v-slot="{ field, state }">
              <label :htmlFor="field.name">Located in</label>
              <UInput
                :name="field.name"
                type="text"
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
          <form.Field name="website">
            <template v-slot="{ field, state }">
              <label :htmlFor="field.name">Website</label>
              <UInput
                :name="field.name"
                type="url"
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
          <form.Field name="bio">
            <template v-slot="{ field, state }">
              <label :htmlFor="field.name">Tell us about your company</label>
              <UTextarea
                v-model="field.state.value"
                :name="field.name"
                variant="outline"
                :rows="5"
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
      </div>

      <div class="bg-neutral-700/20 rounded p-5 flex flex-col gap-4">
        <h3 class="text-2xl font-bold">Password Reset</h3>
        <div class="flex flex-col gap-2">
          <form.Field name="password">
            <template v-slot="{ field, state }">
              <label :htmlFor="field.name">Change Your Password</label>
              <UInput
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
          <form.Field name="password_confirmation">
            <template v-slot="{ field, state }">
              <label :htmlFor="field.name">Confirm Your New Password</label>
              <UInput
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
      </div>

      <UButton
        type="submit"
        class="justify-center hover:cursor-pointer w-full mb-5"
        size="xl"
        label="Save changes"
        :loading="form.useStore((meta) => meta.isSubmitting).value"
        :disabled="
          form.useStore((meta) => meta.isSubmitting).value ||
          !form.useStore((meta) => meta.isDirty).value
        "
      />
    </form>
  </div>
</template>

<script setup lang="ts">
  import { useForm } from '@tanstack/vue-form'
  import type {
    GameDeveloperAPI,
    UpdateGameDeveloperResponse,
  } from '~/types/GameDeveloper'

  const props = defineProps<{
    user: GameDeveloperAPI | null
    isLoading: boolean
  }>()

  const { token } = useAuth()

  const toast = useToast()

  function showToast() {
    toast.add({
      title: 'Success',
      description: 'Your action was completed successfully.',
      color: 'success',
    })
  }

  const form = useForm({
    onSubmit: async ({ value }) => {
      try {
        const response: UpdateGameDeveloperResponse = await $fetch(
          `/api/v1/game_developers/me`,
          {
            baseURL: useRuntimeConfig().public.apiBase,
            method: 'PATCH',
            headers: {
              'Content-Type': 'application/json',
              Authorization: `Bearer ${token.value}`,
            },
            body: {
              game_developer: {
                email: value.email,
                studio_name: value.studio_name,
                website: value.website,
                location: value.location,
                bio: value.bio,
                avatar: value.avatar,
                password: value.password,
                password_confirmation: value.password_confirmation,
              },
            },
          },
        )
        if (response && response.errors) {
          console.error('Update failed:', response.errors)
        } else {
          form.reset({
            email: value.email,
            studio_name: value.studio_name,
            website: value.website,
            location: value.location,
            bio: value.bio,
            avatar: value.avatar,
            password: '',
            password_confirmation: '',
          })
          showToast()

          return response
        }
      } catch (error) {
        console.error('An unexpected error occurred:', error)
      }
    },
    defaultValues: {
      email: props.user?.email,
      studio_name: props.user?.studio_name,
      website: props.user?.website,
      location: props.user?.location,
      bio: props.user?.bio,
      avatar: props.user?.avatar,
      password: '',
      password_confirmation: '',
    },
  })
</script>

<style lang="css" scoped></style>
