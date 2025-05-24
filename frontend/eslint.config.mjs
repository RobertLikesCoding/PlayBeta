import nuxtConfig from './.nuxt/eslint.config.mjs'
import prettier from 'eslint-config-prettier'

export default [
  nuxtConfig,
  ...prettier(),
  {
    rules: {
      'prettier/prettier': 'warn', // shows Prettier issues in ESLint
      // your other rules here...
    },
  },
]
