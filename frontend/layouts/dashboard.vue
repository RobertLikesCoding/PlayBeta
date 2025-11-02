<template>
  <div class="container mx-auto max-w-6xl">
    <header>
      <Navbar />
    </header>

    <h1 class="text-2xl pb-10">
      {{
        user?.studio_name
          ? `Welcome back, Studio ${user?.studio_name}!`
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
              :to="`/dashboard/${item.section}`"
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
            :user="user"
            :isLoading="isLoading"
            v-else
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

  type MenuSection = 'submissions' | 'profile' | 'settings'

  const { user, isLoading, fetchUser } = useCurrentUser()

  const menu: { section: MenuSection; label: string }[] = [
    { section: 'submissions', label: 'Submissions' },
    { section: 'profile', label: 'Profile' },
    { section: 'settings', label: 'Settings' },
  ]

  onMounted(fetchUser)
</script>
