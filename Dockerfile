# FROM node:12

# WORKDIR /usr/src/app
# COPY package.json ./
# COPY babel.config.json ./
# RUN npm install
# COPY temp/dist ./dist

# EXPOSE 4200

# CMD npm run start

FROM node:12 AS build
WORKDIR /usr/src/app
COPY package-lock.json ./
COPY package.json ./
COPY babel.config.json ./
RUN npm install
COPY . .

RUN npm run build

FROM node:12 AS server
WORKDIR /root/
COPY package-lock.json ./
COPY package.json ./
RUN npm install --prod
COPY --from=build /usr/src/app/dist ./dist

EXPOSE 4200

CMD ["npm", "run", "start"]