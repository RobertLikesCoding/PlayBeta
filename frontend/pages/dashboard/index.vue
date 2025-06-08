<template>
  <div>
    <h1>ACCOUNT DASHBOARD</h1>
    <div>
      <p>{{ user?.id }}</p>
    </div>
  </div>
</template>

<script setup lang="ts">
  import { ref, onMounted } from 'vue'
  import type { GameDeveloperAPI } from '~/types/GameDeveloper'

  definePageMeta({
    middleware: ['auth'],
  })

  const { token, isAuthenticated } = useAuth()
  const user = ref<GameDeveloperAPI | null>(null)

  onMounted(async () => {
    if (isAuthenticated) {
      user.value = await fetchCurrentUser()
    }
  })

  async function fetchCurrentUser(): Promise<GameDeveloperAPI> {
    return await $fetch('/api/v1/game_developers/me', {
      baseURL: useRuntimeConfig().public.apiBase,
      headers: { Authorization: `Bearer ${token.value}` },
    })
  }
</script>

<style lang="css" scoped></style>
