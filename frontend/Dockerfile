FROM node:lts-alpine

WORKDIR /frontend

COPY ["package.json", "package-lock.json", "./"]

RUN npm install

COPY . .

EXPOSE 3001

CMD ["npm", "run", "dev"]
