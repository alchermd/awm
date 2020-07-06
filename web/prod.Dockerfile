# build environment
FROM node:13.12.0-alpine as build
WORKDIR /frontend
ENV PATH /frontend/node_modules/.bin:$PATH
COPY ./frontend/package.json ./
COPY ./frontend/package-lock.json ./
RUN npm ci --silent
RUN npm install react-scripts@3.4.1 -g --silent
COPY ./frontend/ ./
RUN npm run build

# pull official base image
FROM python:3.8.3-alpine

# set work directory
ENV APP_HOME=/usr/src/web
WORKDIR $APP_HOME
RUN mkdir $APP_HOME/static

# set environment variables
ENV PYTHONDONTWRITEBYTECODE 1
ENV PYTHONUNBUFFERED 1

# install psycopg2 dependencies
RUN apk update \
    && apk add postgresql-dev gcc python3-dev musl-dev

# install dependencies
COPY requirements.prod.txt .
RUN pip install --upgrade pip
RUN pip install -r requirements.prod.txt

# copy project
COPY . .
RUN mkdir ./frontend/build/
COPY --from=build /frontend/build/ ./frontend/build/