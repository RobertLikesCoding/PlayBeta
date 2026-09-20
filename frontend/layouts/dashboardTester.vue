<template>
  <div class="container mx-auto max-w-6xl">
    <header>
      <NavBar />
    </header>

    <h1 class="text-2xl pb-10">
      {{
        user && 'username' in user && user.username
          ? `Welcome back, ${user.username}!`
          : 'Welcome back!'
      }}
    </h1>
    <div class="flex gap-8">
      <nav>
        <ul class="flex flex-col gap-1 w-40">
          <li
            v-for="(item, index) in menu"
            :key="index"
          >
            <NuxtLink
              :to="`/tester/dashboard/${item.section}`"
              :class="[
                'block cursor-pointer hover:bg-accented rounded p-2 h-full',
                { 'bg-accented': $route.path.includes(item.section) },
              ]"
            >
              {{ item.label }}
            </NuxtLink>
          </li>
        </ul>
      </nav>

      <main class="w-full">
        <section class="px-5 w-full h-fit">
          <LoadingSpinner v-if="isLoading" />
          <NuxtPage
            v-else
            :user="user"
            :is-loading="isLoading"
          />
        </section>
      </main>
    </div>

    <Footer />
  </div>
</template>

<script setup lang="ts">
  import LoadingSpinner from '~/components/common/LoadingSpinner.vue'

  definePageMeta({
    middleware: ['auth'],
  })

  type MenuSection = 'invitations' | 'profile' | 'settings'

  const { user, isLoading, fetchUser, isDev } = useCurrentUser()
  const redirectPath = isDev.value ? '/dev/auth/login' : '/tester/auth/login'

  watchEffect(() => !user.value && navigateTo(redirectPath))

  const menu: { section: MenuSection; label: string }[] = [
    { section: 'invitations', label: 'Invitations' },
    { section: 'profile', label: 'Profile' },
    { section: 'settings', label: 'Settings' },
  ]

  onMounted(fetchUser)
</script>
