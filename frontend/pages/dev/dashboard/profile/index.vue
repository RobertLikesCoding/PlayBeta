<template>
  <div>
    <form
      class="flex flex-col gap-5"
      @submit.prevent="form.handleSubmit()"
    >
      <section
        class="bg-neutral-700/20 rounded p-5 flex flex-col gap-4"
        data-test-id="profile-section"
      >
        <h3 class="text-2xl font-bold">Profile</h3>

        <div class="flex flex-col gap-2">
          <form.Field
            name="email"
            :validators="{
              onBlur: ({ value }) => {
                validateEmail(value)
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
                variant="outline"
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

        <div class="flex flex-col gap-2">
          <form.Field name="avatar">
            <template #default="{ field, state }">
              <label :htmlFor="field.name">Avatar</label>
              <UInput
                :id="field.name"
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
                v-for="(error, index) of state.meta.errors"
                :key="index"
                class="text-red-300"
                role="alert"
                >{{ error }}
              </em>
            </template>
          </form.Field>
        </div>

        <div class="flex flex-col gap-2">
          <form.Field name="studio_name">
            <template #default="{ field, state }">
              <label :htmlFor="field.name">Studio Name</label>
              <UInput
                :id="field.name"
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
                v-for="(error, index) of state.meta.errors"
                :key="index"
                class="text-red-300"
                role="alert"
                >{{ error }}
              </em>
            </template>
          </form.Field>
        </div>

        <div class="flex flex-col gap-2">
          <form.Field name="location">
            <template #default="{ field, state }">
              <label :htmlFor="field.name">Located in</label>
              <UInput
                :id="field.name"
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
                v-for="(error, index) of state.meta.errors"
                :key="index"
                class="text-red-300"
                role="alert"
                >{{ error }}
              </em>
            </template>
          </form.Field>
        </div>

        <div class="flex flex-col gap-2">
          <form.Field
            name="website"
            :validators="{
              onSubmit: ({ value }) => {
                if (value && !value?.startsWith('https://'))
                  return 'Please provide only save URLs starting with https'
              },
            }"
          >
            <template #default="{ field, state }">
              <label :htmlFor="field.name">Website</label>
              <UInput
                :id="field.name"
                :name="field.name"
                type="url"
                :value="field.state.value"
                variant="outline"
                placeholder="https://example.com"
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

        <div class="flex flex-col gap-2">
          <form.Field name="bio">
            <template #default="{ field, state }">
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
                v-for="(error, index) of state.meta.errors"
                :key="index"
                class="text-red-300"
                role="alert"
                >{{ error }}
              </em>
            </template>
          </form.Field>
        </div>
      </section>

      <form.Subscribe>
        <template
          #default="{ canSubmit, isSubmitting, isSubmitted, isTouched }"
        >
          <UButton
            type="submit"
            class="justify-center hover:cursor-pointer w-full mb-5"
            size="xl"
            :label="
              isSubmitted && !isTouched ? 'Changes saved!' : 'Save changes'
            "
            :loading="form.useSelector((meta) => meta.isSubmitting).value"
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
    layout: 'dashboard-developer',
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
        const response = await $fetch<UpdateGameDeveloperResponse>(
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
            email: value.email,
            studio_name: value.studio_name,
            website: value.website,
            location: value.location,
            bio: value.bio,
            avatar: value.avatar,
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
      email: props.user?.email ?? '',
      studio_name: props.user?.studio_name ?? '',
      website: props.user?.website ?? '',
      location: props.user?.location ?? '',
      bio: props.user?.bio ?? '',
      avatar: props.user?.avatar ?? '',
    },
  })
</script>
