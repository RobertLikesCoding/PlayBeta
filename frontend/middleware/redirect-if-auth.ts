export default defineNuxtRouteMiddleware((to, from) => {
  const { isAuthenticated } = useAuth()

  if (isAuthenticated.value) {
    return to.fullPath.includes('dev')
      ? navigateTo('/dev/dashboard/submissions')
      : navigateTo('/tester/dashboard/submissions')
  }
})
