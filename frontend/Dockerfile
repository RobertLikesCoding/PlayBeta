FROM node:lts-alpine
WORKDIR /nuxt
COPY ["package.json", "package-lock.json*", "./"]
RUN npm install --silent
COPY . .
EXPOSE 3001
CMD ["npm", "run", "dev"]
