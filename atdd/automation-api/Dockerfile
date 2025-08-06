FROM node:alpine
RUN npm install -g newman newman-reporter-htmlextra
WORKDIR /etc/newman

COPY . .
# COPY entrypoint.sh .
ENTRYPOINT ["sh", "./entrypoint.sh"]
