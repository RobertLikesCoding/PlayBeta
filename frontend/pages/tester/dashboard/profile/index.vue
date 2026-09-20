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
          <form.Field name="username">
            <template #default="{ field, state }">
              <label :htmlFor="field.name">Username</label>
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

        <div class="flex flex-col gap-2">
          <form.Field name="gender">
            <template #default="{ field, state }">
              <label :htmlFor="field.name">Gender</label>
              <USelect
                :id="field.name"
                :model-value="field.state.value"
                :name="field.name"
                label-key="label"
                value-key="value"
                :items="genderOptions"
                placeholder="Select a gender option"
                variant="subtle"
                @update:model-value="field.handleChange"
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

        <!-- <div class="flex flex-col gap-2">
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
        </div> -->
      </section>

      <form.Subscribe>
        <template #default="{ canSubmit, isSubmitting, isTouched }">
          <UButton
            type="submit"
            class="justify-center hover:cursor-pointer w-full mb-5"
            size="xl"
            label="Save changes"
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
  import {
    ALLOWED_GENDER_OPTIONS,
    type GameTesterAPI,
    type UpdateGameTesterResponse,
  } from '~/types/GameTesterAPI'

  definePageMeta({
    layout: 'dashboard-tester',
  })

  const props = defineProps<{
    user: GameTesterAPI | null
    isLoading: boolean
  }>()

  const { token } = useAuth()
  const toast = useToast()
  const { updateUser } = useCurrentUser()

  const form = useForm({
    onSubmit: async ({ value }) => {
      try {
        const response = await $fetch<UpdateGameTesterResponse>(
          `/api/v1/game_testers/me`,
          {
            baseURL: useRuntimeConfig().public.apiBase,
            method: 'PATCH',
            headers: {
              'Content-Type': 'application/json',
              Authorization: `Bearer ${token.value}`,
            },
            body: {
              game_tester: {
                email: value.email,
                birthdate: value.birthdate,
                // location: value.location,
                // avatar: value.avatar,
                gender: value.gender,
                username: value.username,
              },
            },
          },
        )

        if (response && 'errors' in response) {
          console.error('Update failed:', response.errors)
          toast.add({
            title: 'Error',
            description: 'Saving failed. Please try again',
            color: 'error',
            icon: 'i-lucide-x-circle',
          })
        } else {
          const updatedUser = response.data
          updateUser(updatedUser)

          form.reset({
            email: updatedUser.email ?? '',
            birthdate: updatedUser.birthdate ?? '',
            // location: updatedUser.location ?? '',
            avatar: updatedUser.avatar ?? '',
            gender: updatedUser.gender ?? '',
            username: updatedUser.username ?? '',
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
      birthdate: props.user?.birthdate ?? '',
      // location: props.user?.location ?? '',
      avatar: props.user?.avatar ?? '',
      gender: props.user?.gender ?? '',
      username: props.user?.username ?? '',
    },
  })

  const genderOptions = ALLOWED_GENDER_OPTIONS.map((option) => {
    return {
      label: option.replaceAll('_', ' '),
      value: option,
    }
  })
</script>
