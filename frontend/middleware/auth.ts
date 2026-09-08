export default defineNuxtRouteMiddleware((to, from) => {
  const { isAuthenticated } = useAuth()

  if (!isAuthenticated.value) {
    return to.fullPath.includes('dev')
      ? navigateTo('/dev/auth/login')
      : navigateTo('/tester/auth/login')
  }
})
