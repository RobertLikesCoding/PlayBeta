<template>
  <div>
    <form
      @submit.prevent="form.handleSubmit()"
      class="flex flex-col gap-5"
    >
      <div class="flex flex-col gap-2">
        <form.Field name="email">
          <template v-slot="{ field, state }">
            <label :htmlFor="field.name">Email</label>
            <UInput
              :name="field.name"
              type="email"
              :value="field.state.value"
              variant="subtle"
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
              variant="subtle"
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
              variant="subtle"
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
              variant="subtle"
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
              variant="subtle"
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
            <UInput
              :name="field.name"
              type="text"
              :value="field.state.value"
              variant="subtle"
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

      <UButton
        type="submit"
        class="mt-2 justify-center hover:cursor-pointer"
        size="xl"
        label="Save changes"
        :loading="form.useStore((meta) => meta.isSubmitting).value"
        :disabled="form.useStore((meta) => meta.isSubmitting).value"
      />
    </form>
  </div>
</template>

<script setup lang="ts">
  import { useForm } from '@tanstack/vue-form'
  import type { GameDeveloperAPI } from '~/types/GameDeveloper'

  const props = defineProps<{
    user: GameDeveloperAPI | null
  }>()

  const form = useForm({
    onSubmit: async ({ value }) => {
      console.log('submitted')
    },
    defaultValues: {
      email: props.user?.email,
      studio_name: props.user?.studio_name,
      website: props.user?.website,
      location: props.user?.location,
      bio: props.user?.bio,
      avatar: props.user?.avatar,
    },
  })
</script>

<style lang="css" scoped></style>
