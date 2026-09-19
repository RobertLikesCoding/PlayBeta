export default defineNuxtRouteMiddleware((to, from) => {
  const { isAuthenticated } = useAuth()

  if (!isAuthenticated.value) {
    return to.path.includes('dev')
      ? navigateTo('/dev/auth/login')
      : navigateTo('/tester/auth/login')
  }
})
