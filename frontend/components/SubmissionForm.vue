<template>
  <form
    class="flex flex-col gap-5"
    @submit.prevent="form.handleSubmit()"
  >
    <section data-test-id="basic-info-section">
      <div class="bg-neutral-700/20 rounded p-5 flex flex-col gap-4">
        <h3 class="text-2xl font-bold">Basic Information</h3>

        <div class="flex flex-col gap-2">
          <form.Field
            name="title"
            :validators="{
              onSubmit: ({ value }) => !value.trim() && PRESENCE_ERROR,
            }"
          >
            <template #default="{ field, state }">
              <label :htmlFor="field.name">Title</label>
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
            name="description"
            :validators="{
              onSubmit: ({ value }) => !value.trim() && PRESENCE_ERROR,
            }"
          >
            <template #default="{ field, state }">
              <label :htmlFor="field.name">Description</label>
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

        <div class="flex flex-col gap-2">
          <form.Field
            name="genre"
            :validators="{
              onChange: ({ value }) =>
                !value.length && 'Please select at least 1 genre',
            }"
          >
            <template #default="{ field, state }">
              <label :htmlFor="field.name">Genre</label>
              <USelect
                :id="field.name"
                :name="field.name"
                :model-value="field.state.value"
                :items="genreList"
                multiple
                placeholder="Select a genre"
                @update:model-value="field.handleChange"
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
            name="version"
            :validators="{
              onSubmit: ({ value }) => !value.trim() && PRESENCE_ERROR,
            }"
          >
            <template #default="{ field, state }">
              <label :htmlFor="field.name">Version</label>
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
            name="platforms"
            :validators="{
              onSubmit: ({ value }) =>
                !value.length && 'Please select at least 1 platform',
            }"
          >
            <template #default="{ field, state }">
              <label :htmlFor="field.name">Platforms</label>
              <UCheckboxGroup
                v-model="field.state.value"
                :items="platformList"
                orientation="horizontal"
                @update:model-value="field.handleChange"
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
    </section>

    <div class="bg-neutral-700/20 rounded p-5 flex flex-col gap-4">
      <h3 class="text-2xl font-bold">Demo Link</h3>
      <div class="flex flex-col gap-2">
        <form.Field
          name="demo_url"
          :validators="{
            onSubmit: ({ value }) => validateDemoUrl(value),
          }"
        >
          <template #default="{ field, state }">
            <label :htmlFor="field.name">Demo Link</label>
            <UInput
              :id="field.name"
              :name="field.name"
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
    </div>

    <form.Subscribe>
      <template #default="{ canSubmit, isSubmitting, isTouched }">
        <UButton
          type="submit"
          class="justify-center hover:cursor-pointer w-full mb-5"
          size="xl"
          :label="mode === 'edit' ? 'Update Submission' : 'Create Submission'"
          :loading="isSubmitting"
          :disabled="isSubmitting || !canSubmit || !isTouched"
        />
      </template>
    </form.Subscribe>
  </form>
</template>

<script setup lang="ts">
  import { useForm } from '@tanstack/vue-form'
  import type {
    CreateSubmissionResponse,
    Submission,
    SubmissionConstants,
  } from '~/types/Submission'

  const props = defineProps<{
    mode: 'edit' | 'create'
    submission?: Submission
  }>()

  const { token } = useAuth()
  const toast = useToast()

  const { platforms, genres } = await $fetch<SubmissionConstants>(
    '/api/v1/submissions/constants',
    {
      baseURL: useRuntimeConfig().public.apiBase,
    },
  )

  const genreList = computed(() => {
    return genres.map((genre) => ({
      label: genre.name[0]?.toUpperCase() + genre.name.substring(1),
      value: String(genre.id),
    }))
  })
  const platformList = computed(() => {
    return platforms.map((platform) => ({
      label: platform.name[0]?.toUpperCase() + platform.name.substring(1),
      value: String(platform.id),
    }))
  })

  const form = useForm({
    onSubmit: async ({ value }) => {
      const isCreate = props.mode === 'create'
      const requestPath = isCreate
        ? '/api/v1/submissions'
        : `/api/v1/submissions/${props.submission?.s_id}`
      try {
        const response = await $fetch<CreateSubmissionResponse>(requestPath, {
          baseURL: useRuntimeConfig().public.apiBase,
          method: props.mode === 'create' ? 'POST' : 'PATCH',
          headers: {
            'Content-Type': 'application/json',
            Authorization: `Bearer ${token.value}`,
          },
          body: {
            submission: {
              title: value.title,
              description: value.description,
              genre_ids: value.genre,
              platform_ids: value.platforms,
              demo_url: value.demo_url,
              version: value.version,
            },
          },
        })

        if ('errors' in response) {
          console.error('Submission failed', response.errors)
          toast.add({
            title: 'Error',
            description: 'Failed to create your submission. Please try again.',
            color: 'error',
            icon: 'i-lucide-x-circle',
          })
        } else {
          await navigateTo('/dev/dashboard/submissions')
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
      title: props.submission?.title ?? '',
      description: props.submission?.description ?? '',
      genre: props.submission?.genres.map((genre) => String(genre.id)) ?? [],
      platforms:
        props.submission?.platforms.map((plat) => String(plat.id)) ?? [],
      demo_url: props.submission?.demo_url ?? '',
      version: props.submission?.version ?? '',
    },
  })
</script>
