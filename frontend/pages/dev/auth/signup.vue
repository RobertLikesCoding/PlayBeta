<template>
  <SignUpForm
    mode="dev"
    info-text="By signing up, you can upload your demos, connect with dedicated playtesters, and gather insights to improve your game."
  />
</template>

<script setup lang="ts">
  import SignUpForm from '~/components/common/SignUpForm.vue'
  // this is for setting the layout for the auth pages seperatly from the default layout
  definePageMeta({
    layout: 'auth',
    middleware: ['redirect-if-auth'],
  })
</script>
