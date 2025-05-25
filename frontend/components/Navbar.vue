<template>
  <nav class="flex items-center justify-between flex-wrap">
    <div class="flex items-center flex-shrink-0 text-white mr-6 px-5">
      <span class="font-semibold text-xl tracking-tight">PlayBeta</span>
    </div>

    <!-- HAMBURGER BUTTON -->
    <div class="block lg:hidden p-5">
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
    <div class="w-full block flex-grow lg:flex lg:items-center lg:w-auto">
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

      <NuxtLink
        to="auth/signup"
        class="text-sm px-4 py-2 leading-none border rounded text-white border-white hover:border-transparent hover:text-green-500 hover:bg-white hidden lg:block mr-5"
        >Account
      </NuxtLink>

      <!-- MOBILE MENU -->
      <Transition
        enter-active-class="transition-opacity transition-transform duration-300 ease-out"
        enter-from-class="opacity-0 -translate-y-2"
        enter-to-class="opacity-100 translate-y-0"
      >
        <div
          class="absolute bg-neutral-900 w-full text-sm lg:flex-grow block lg:hidden px-5 pb-5"
          v-show="isMenuOpen"
        >
          <NuxtLink
            to="#responsive-header"
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
          <NuxtLink
            to="auth/signup"
            class="inline-block text-sm px-4 py-2 leading-none border rounded text-white border-white hover:border-transparent hover:text-green-500 hover:bg-white mt-4 lg:mt-0"
            >Account
          </NuxtLink>
        </div>
      </Transition>
    </div>
  </nav>
</template>

<script setup lang="ts">
  const isMenuOpen = ref(false)
</script>
