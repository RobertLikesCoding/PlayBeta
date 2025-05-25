<template>
  <div class="container mx-auto max-w-6xl px-5">
    <header>
      <Navbar />
    </header>

    <main>
      <slot />
    </main>

    <Footer />
  </div>
</template>

<script setup lang="ts">
  import Navbar from '~/components/Navbar.vue'
</script>
