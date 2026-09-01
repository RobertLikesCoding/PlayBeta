<template>
  <LoginForm
    mode="tester"
    info-text="Sign in with your Game Tester account"
  />
</template>

<script setup lang="ts">
  import LoginForm from '~/components/common/LoginForm.vue'

  definePageMeta({
    layout: 'auth',
    middleware: ['redirect-if-auth'],
  })
</script>
