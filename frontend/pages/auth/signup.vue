<template>
  <h1>Sign Up</h1>
  <form action=""></form>
</template>


<script setup>
  definePageMeta({
    layout: 'auth'
  })

  const form = useForm({
    onSubmit: async ({ value }) => {
      // Do something with form data
      console.log(value)
    },
    defaultValues: {
      email: "",
      password: "",
      passwordConfirmation: "",
    },
  })

</script>
