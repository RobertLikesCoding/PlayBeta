<template>
  <div>
    <div class="flex flex-col gap-4 mb-4">
      <NuxtLink to="dashboard/submissions">
        <UButton
          icon="i-lucide-arrow-left"
          size="xl"
          variant="outline"
          color="neutral"
          class="w-fit"
          >Back</UButton
        >
      </NuxtLink>
      <h2 class="text-3xl font-bold">Create a new submission</h2>
    </div>
    <form
      @submit.prevent="form.handleSubmit()"
      class="flex flex-col gap-5"
    >
      <div class="bg-neutral-700/20 rounded p-5 flex flex-col gap-4">
        <h3 class="text-2xl font-bold">Basic Information</h3>

        <div class="flex flex-col gap-2">
          <form.Field name="title">
            <template v-slot="{ field, state }">
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
                v-for="error of state.meta.errors"
                class="text-red-300"
                role="alert"
                >{{ error }}
              </em>
            </template>
          </form.Field>
        </div>

        <div class="flex flex-col gap-2">
          <form.Field name="description">
            <template v-slot="{ field, state }">
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
                v-for="error of state.meta.errors"
                class="text-red-300"
                role="alert"
                >{{ error }}
              </em>
            </template>
          </form.Field>
        </div>

        <div class="flex flex-col gap-2">
          <form.Field name="Genre">
            <template v-slot="{ field, state }">
              <label :htmlFor="field.name">Genre</label>
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
                v-for="error of state.meta.errors"
                class="text-red-300"
                role="alert"
                >{{ error }}
              </em>
            </template>
          </form.Field>
        </div>

        <div class="flex flex-col gap-2">
          <form.Field name="version">
            <template v-slot="{ field, state }">
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
                v-for="error of state.meta.errors"
                class="text-red-300"
                role="alert"
                >{{ error }}
              </em>
            </template>
          </form.Field>
        </div>

        <div class="flex flex-col gap-2">
          <form.Field name="platforms">
            <template v-slot="{ field, state }">
              <label :htmlFor="field.name">Platforms</label>
              <UCheckboxGroup
                v-model="value"
                :items="items"
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
        </div>
      </div>

      <div class="bg-neutral-700/20 rounded p-5 flex flex-col gap-4">
        <h3 class="text-2xl font-bold">Demo Link</h3>
        <div class="flex flex-col gap-2">
          <form.Field name="demo_url">
            <template v-slot="{ field, state }">
              <label :htmlFor="field.name">Demo Link</label>
              <UInput
                :id="field.name"
                :name="field.name"
                type="url"
                :value="field.state.value"
                variant="outline"
                @input="
                  (e: Event) => (e: Event) =>
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

  definePageMeta({
    layout: 'dashboard',
  })

  const toast = useToast()

  function showToast() {
    toast.add({
      title: 'Success',
      description: 'Your action was completed successfully.',
      color: 'success',
    })
  }

  const items = ref(['Playstation', 'Xbox', 'Steam'])
  const value = ref(['System'])

  const form = useForm({
    onSubmit: async ({ value }) => {
      try {
      } catch (error) {}
    },
  })
</script>
