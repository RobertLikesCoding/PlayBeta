<template>
  <SignUpForm
    mode="tester"
    info-text="By signing up, you create an account an can start getting invititations to game demos"
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
