<template>
  <div class="container mx-auto max-w-6xl">
    <header>
      <Navbar />
    </header>

    <main class="p-5">
      <slot />
    </main>

    <Footer />
  </div>
</template>

<script setup lang="ts">
  import Navbar from '~/components/Navbar.vue'
</script>
