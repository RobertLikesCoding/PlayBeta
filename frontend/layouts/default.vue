<template>
  <div class="container mx-auto max-w-6xl">
    <header>
      <NavBar />
    </header>

    <main class="p-5">
      <slot />
    </main>

    <Footer />
  </div>
</template>

<script setup lang="ts">
  import NavBar from '~/components/NavBar.vue'
</script>
