export default defineNuxtRouteMiddleware((to, from) => {
  // everything after /dev or /tester are protected routes that require login
  const isProtectedPath =
    to.path.startsWith('/dev') || to.path.startsWith('/tester')

  // except the auth routes
  const isAuthPath = to.path.includes('/auth')

  if (isProtectedPath && !isAuthPath) {
    const { isAuthenticated } = useAuth()

    if (!isAuthenticated.value) {
      return to.path.startsWith('/dev')
        ? navigateTo('/dev/auth/login')
        : navigateTo('/tester/auth/login')
    }
  }
})
