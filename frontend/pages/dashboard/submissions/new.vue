<template>
  <div>
    <div class="flex flex-col gap-4 mb-4">
      <UButton
        icon="i-lucide-arrow-left"
        size="xl"
        variant="outline"
        color="neutral"
        class="w-fit"
        to="/dashboard/submissions"
        >Back</UButton
      >
      <h2 class="text-3xl font-bold">Create a new submission</h2>
    </div>

    <form
      @submit.prevent="form.handleSubmit()"
      class="flex flex-col gap-5"
    >
      <div class="bg-neutral-700/20 rounded p-5 flex flex-col gap-4">
        <h3 class="text-2xl font-bold">Basic Information</h3>

        <div class="flex flex-col gap-2">
          <form.Field
            name="title"
            :validators="{
              onSubmit: ({ value }) =>
                !value ? 'Title is required' : undefined,
            }"
          >
            <template v-slot="{ field, state }">
              <label :htmlFor="field.name">Title</label>
              <UInput
                :id="field.name"
                :name="field.name"
                type="text"
                :value="field.state.value"
                variant="outline"
                @update:modelValue="field.handleChange"
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
          <form.Field
            name="description"
            :validators="{
              onSubmit: ({ value }) =>
                !value ? 'Description is required' : undefined,
            }"
          >
            <template v-slot="{ field, state }">
              <label :htmlFor="field.name">Description</label>
              <UTextarea
                v-model="field.state.value"
                :name="field.name"
                variant="outline"
                :rows="5"
                @update:modelValue="field.handleChange"
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
          <form.Field
            name="genre"
            :validators="{
              onChange: ({ value }) =>
                !value.length && 'Please select at least 1 genre',
            }"
          >
            <template v-slot="{ field, state }">
              <label :htmlFor="field.name">Genre</label>
              <USelect
                :id="field.name"
                :name="field.name"
                :value="field.state.value"
                :items="genres"
                multiple
                placeholder="Select a genre"
                @update:modelValue="
                  (val: unknown) => field.handleChange(val as string[])
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
          <form.Field
            name="version"
            :validators="{
              onSubmit: ({ value }) =>
                !value ? 'Version is required' : undefined,
            }"
          >
            <template v-slot="{ field, state }">
              <label :htmlFor="field.name">Version</label>
              <UInput
                :id="field.name"
                :name="field.name"
                type="text"
                :value="field.state.value"
                variant="outline"
                @update:modelValue="field.handleChange"
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
          <form.Field
            name="platforms"
            :validators="{
              onSubmit: ({ value }) =>
                !value.length && 'Please select at least 1 platform',
            }"
          >
            <template v-slot="{ field, state }">
              <label :htmlFor="field.name">Platforms</label>
              <UCheckboxGroup
                v-model="field.state.value"
                :items="sortedPlatforms"
                orientation="horizontal"
                @update:modelValue="
                  (val: unknown) => field.handleChange(val as string[])
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

        <!-- <div class="flex flex-col gap-2">
          <form.Field name="Screenshots">
            <template v-slot="{ field, state }">
              <label :htmlFor="field.name">Screenshots</label>
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
                v-for="error of state.meta.errors"
                class="text-red-300"
                role="alert"
                >{{ error }}
              </em>
            </template>
          </form.Field>
        </div> -->
      </div>

      <div class="bg-neutral-700/20 rounded p-5 flex flex-col gap-4">
        <h3 class="text-2xl font-bold">Demo Link</h3>
        <div class="flex flex-col gap-2">
          <form.Field
            name="demo_url"
            :validators="{
              onSubmit: ({ value }) =>
                !value ? 'Please provide a link to the demo' : undefined,
            }"
          >
            <template v-slot="{ field, state }">
              <label :htmlFor="field.name">Demo Link</label>
              <UInput
                :id="field.name"
                :name="field.name"
                type="url"
                :value="field.state.value"
                variant="outline"
                placeholder="https://example.com"
                @update:modelValue="field.handleChange"
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

      <form.Subscribe>
        <template v-slot="{ canSubmit, isSubmitting, isTouched }">
          <UButton
            type="submit"
            class="justify-center hover:cursor-pointer w-full mb-5"
            size="xl"
            :label="isSubmitting ? 'Submitting' : 'Create Submission'"
            :loading="isSubmitting"
            :disabled="isSubmitting || !canSubmit || !isTouched"
          />
        </template>
      </form.Subscribe>
    </form>
  </div>
</template>
<script setup lang="ts">
  import { useForm } from '@tanstack/vue-form'
  import type { SubmissionResponse } from '~/types/Submission'

  definePageMeta({
    layout: 'dashboard',
  })

  const { token } = useAuth()
  const toast = useToast()

  const platforms = ['Playstation', 'Xbox', 'Steam', 'Switch']
  const genres = [
    'action',
    'adventure',
    'rpg',
    'simulation',
    'strategy',
    'sports',
    'puzzle',
    'horror',
    'platformer',
    'shooter',
    'fighting',
    'racing',
    'sandbox',
  ]
  const sortedPlatforms = computed(() => {
    return platforms.toSorted()
  })

  onMounted(async () => {
    await form.validate('mount')
  })

  const form = useForm({
    onSubmit: async ({ value }) => {
      try {
        const response: SubmissionResponse = await $fetch(
          '/api/v1/submissions',
          {
            baseURL: useRuntimeConfig().public.apiBase,
            method: 'POST',
            headers: {
              'Content-Type': 'application/json',
              Authorization: `Bearer ${token.value}`,
            },
            body: {
              submission: {
                title: value.title,
                description: value.description,
                genre: value.genre,
                platforms: value.platforms,
                demo_url: value.demo_url,
                version: value.version,
              },
            },
          },
        )

        if (response && response.errors) {
          console.error('Submission failed', response.errors)
          toast.add({
            title: 'Error',
            description: 'Failed to create your submission. Please try again.',
            color: 'error',
            icon: 'i-lucide-x-circle',
          })
        } else {
          await navigateTo('/dashboard/submissions')
          toast.add({
            title: 'Success',
            description: 'Your submission was created successfully.',
            color: 'success',
            icon: 'i-lucide-check-circle',
          })
        }
      } catch (error) {
        console.error('An unexpected error occurred:', error)
      }
    },
    defaultValues: {
      title: '',
      description: '',
      genre: [] as string[],
      platforms: [] as string[],
      demo_url: '',
      version: '',
    },
  })
</script>
