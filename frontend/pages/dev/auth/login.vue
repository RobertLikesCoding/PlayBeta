<template>
  <LoginForm
    mode="dev"
    info-text="Sign in with your Game Developer account"
  />
</template>

<script setup lang="ts">
  import LoginForm from '~/components/common/LoginForm.vue'

  definePageMeta({
    layout: 'auth',
    middleware: ['redirect-if-auth'],
  })
</script>
