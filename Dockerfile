FROM node:14.21.3-slim

RUN apt-get update -y && apt-get upgrade -y && apt-get install -yq make

WORKDIR /app