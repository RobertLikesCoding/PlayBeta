<template>
  <div>
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
                { 'bg-accented': activeSection === item.section },
              ]"
            >
              {{ item.label }}
            </NuxtLink>
          </li>
        </ul>
      </nav>

      <LoadingSpinner v-if="isLoading" />
      <section
        v-else
        class="px-5 w-full h-fit"
      >
        <UserSubmissions v-if="activeSection === 'submissions'" />
        <UserProfile
          v-if="activeSection === 'profile'"
          :user="user || null"
          :is-loading="isLoading"
        />
        <UserSettings v-if="activeSection === 'settings'" />
      </section>
    </div>
  </div>
</template>

<script setup lang="ts">
  import LoadingSpinner from '~/components/common/LoadingSpinner.vue'
  import UserProfile from '~/components/user/UserProfile.vue'
  import UserSettings from '~/components/user/UserSettings.vue'
  import UserSubmissions from '~/components/user/UserSubmissions.vue'

  definePageMeta({
    middleware: ['auth'],
  })

  type MenuSection = 'submissions' | 'profile' | 'settings'

  const { user, isLoading, fetchUser } = useCurrentUser()
  const route = useRoute()
  const activeSection = computed(() => {
    return route.params.section
  })

  const menu: { section: MenuSection; label: string }[] = [
    { section: 'submissions', label: 'Submissions' },
    { section: 'profile', label: 'Profile' },
    { section: 'settings', label: 'Settings' },
  ]

  onMounted(fetchUser)
</script>
