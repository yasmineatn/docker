# Use the official Node.js image as the base image
FROM node

# Set the working directory inside the container
WORKDIR /app

# Copy the package.json and package-lock.json files
COPY package*.json ./

# Install Angular CLI and project dependencies
RUN npm install -g @angular/cli
RUN npm install

# Copy the compiled files from the local 'dist/' directory to the container
COPY dist/ ./dist/

# Start a new stage to create the production-ready image
FROM nginx:1.21.1

# Copy the compiled files from the previous stage to the NGINX default public directory
COPY --from=build-stage /app/dist/ /usr/share/nginx/html

# Expose the default NGINX port
EXPOSE 80

# The default command to start NGINX when the container is run
CMD ["nginx", "-g", "daemon off;"]