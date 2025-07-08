<template>
  <nav class="flex items-center justify-between flex-wrap px-5 h-24">
    <div class="flex items-center flex-shrink-0 text-white mr-6">
      <NuxtLink
        to="/"
        class="font-semibold text-xl tracking-tight"
        >PlayBeta
      </NuxtLink>
    </div>

    <!-- HAMBURGER BUTTON -->
    <div class="block lg:hidden py-5 z-10">
      <UButton
        @click="isMenuOpen = !isMenuOpen"
        class="flex items-center px-3 py-2 border rounded hover:text-white hover:border-white cursor-pointer"
      >
        <svg
          v-if="!isMenuOpen"
          class="fill-current h-3 w-3"
          viewBox="0 0 20 20"
          xmlns="http://www.w3.org/2000/svg"
        >
          <title>Menu</title>
          <path d="M0 3h20v2H0V3zm0 6h20v2H0V9zm0 6h20v2H0v-2z" />
        </svg>
        <svg
          v-else
          class="fill-current h-3 w-3"
          viewBox="0 0 20 20"
          xmlns="http://www.w3.org/2000/svg"
        >
          <title>Close</title>
          <path
            fill-rule="evenodd"
            d="M6.225 4.811a1 1 0 011.414 0L12 9.172l4.361-4.361a1 1 0 111.414 1.414L13.414 10.5l4.361 4.361a1 1 0 01-1.414 1.414L12 11.828l-4.361 4.361a1 1 0 01-1.414-1.414L10.586 10.5 6.225 6.139a1 1 0 010-1.328z"
            clip-rule="evenodd"
          />
        </svg>
      </UButton>
    </div>

    <!-- DESKTOP MENU -->
    <div
      data-test="desktop-menu"
      class="w-full flex-grow lg:flex lg:items-center lg:w-auto hidden"
    >
      <div class="text-sm hidden lg:block lg:flex-grow py-5">
        <NuxtLink
          to="#responsive-heNuxtLinkder"
          class="block mt-4 lg:inline-block lg:mt-0 text-primary-300 hover:text-white mr-4"
        >
          About Us
        </NuxtLink>
        <NuxtLink
          to="#responsive-header"
          class="block mt-4 lg:inline-block lg:mt-0 text-primary-300 hover:text-white mr-4"
        >
          Services
        </NuxtLink>
        <NuxtLink
          to="#responsive-header"
          class="block mt-4 lg:inline-block lg:mt-0 text-primary-300 hover:text-white"
        >
          Blog
        </NuxtLink>
      </div>

      <button
        v-if="isAuthenticated"
        class="block mt-4 lg:inline-block lg:mt-0 text-primary-300 hover:text-white cursor-pointer mr-5"
        @click="logout"
      >
        Logout
      </button>

      <NuxtLink
        :to="isAuthenticated ? '/dashboard/submissions' : '/auth/signup'"
        class="text-sm px-4 py-2 leading-none border rounded text-white border-white hover:border-transparent hover:text-green-500 hover:bg-white"
        >Account
      </NuxtLink>
    </div>

    <!-- MOBILE MENU -->
    <Transition
      enter-active-class="transition-all duration-200 ease-out"
      enter-from-class="-translate-y-80"
      enter-to-class="translate-y-0"
      leave-active-class="transition-all duration-500 ease-in"
      leave-from-class="translate-y-0"
      leave-to-class="-translate-y-80"
    >
      <div
        class="absolute top-0 right-0 bg-neutral-900 w-full text-sm lg:hidden p-5 z-9"
        v-show="isMenuOpen"
      >
        <NuxtLink
          to="#responsive-header"
          class="block lg:inline-block lg:mt-0 text-primary-300 hover:text-white mt-2"
          @click="isMenuOpen = false"
        >
          About Us
        </NuxtLink>
        <NuxtLink
          to="#responsive-header"
          class="block mt-4 lg:inline-block lg:mt-0 text-primary-300 hover:text-white"
          @click="isMenuOpen = false"
        >
          Services
        </NuxtLink>
        <NuxtLink
          to="#responsive-header"
          class="block mt-4 lg:inline-block lg:mt-0 text-primary-300 hover:text-white"
          @click="isMenuOpen = false"
        >
          Blog
        </NuxtLink>
        <div class="bg-white w-full h-0.5 opacity-5 my-4"></div>
        <button
          v-if="isAuthenticated"
          class="block lg:inline-block lg:mt-0 text-primary-300 hover:text-white cursor-pointer mr-5"
          @click="logout"
        >
          Logout
        </button>
        <NuxtLink
          :to="isAuthenticated ? '/dashboard/submissions' : '/auth/signup'"
          class="inline-block text-sm px-4 py-2 leading-none border rounded text-white border-white hover:border-transparent hover:text-green-500 hover:bg-white mt-4 lg:mt-0"
          @click="isMenuOpen = false"
          >Account
        </NuxtLink>
      </div>
    </Transition>
  </nav>
</template>

<script setup lang="ts">
  const isMenuOpen = ref(false)
  const { isAuthenticated, clearToken } = useAuth()
  const router = useRouter()

  function logout() {
    clearToken()
    router.push('/')
  }
</script>
