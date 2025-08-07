# Stage 1: Build the React application
FROM tcr.ap.toyota-asia.com/hubdocker/library/node:22.18.0 AS build

WORKDIR /app

COPY index.html /app/index.html

# COPY package.json package-lock.json ./
# RUN npm config set loglevel verbose
# RUN npm install

COPY . ./

# RUN npm run build

# Stage 2: Serve the React application with Nginx
FROM tcr.ap.toyota-asia.com/hubdocker/nginx:alpine


COPY --from=build /app /usr/share/nginx/html

# Copy custom Nginx configuration
COPY --from=build /app/default.conf /etc/nginx/conf.d/default.conf

EXPOSE 80

# ENTRYPOINT ["/entrypoint.sh"]
CMD ["nginx", "-g", "daemon off;"]
