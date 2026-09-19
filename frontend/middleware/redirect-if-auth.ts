export default defineNuxtRouteMiddleware((to, from) => {
  const { isAuthenticated } = useAuth()

  if (isAuthenticated.value) {
    return to.path.includes('dev')
      ? navigateTo('/dev/dashboard/submissions')
      : navigateTo('/tester/dashboard/profile')
  }
})
