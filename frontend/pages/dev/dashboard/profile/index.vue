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
                variant="outline"
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
              onBlur: ({ value }) => {
                return validateUrl(value)
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
  import type { GameDeveloperAPI } from '~/types/GameDeveloper'

  definePageMeta({
    layout: 'dashboard-developer',
  })

  const props = defineProps<{
    user: GameDeveloperAPI | null
    isLoading: boolean
  }>()

  const { updateDeveloper } = useGameDeveloperUpdate()

  const form = useForm({
    onSubmit: async ({ value }) => await updateDeveloper(value),
    defaultValues: {
      email: props.user?.email ?? '',
      studio_name: props.user?.studio_name ?? '',
      website: props.user?.website ?? '',
      location: props.user?.location ?? '',
      bio: props.user?.bio ?? '',
      avatar: props.user?.avatar ?? '',
    },
  })

  // this updates the form whenever the user props change
  watch(
    () => props.user,
    (user) => {
      if (!user) return
      form.reset({
        email: user.email,
        studio_name: user.studio_name,
        website: user.website,
        location: user.location,
        bio: user.bio,
        avatar: user.avatar ?? '',
      })
    },
    { immediate: true },
  )
</script>
