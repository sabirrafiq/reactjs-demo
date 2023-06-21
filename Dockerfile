# Use an official Node.js runtime as the base image
FROM node:14

# Set the working directory in the container
WORKDIR /app

# Copy package.json and package-lock.json to the container
COPY package*.json ./

# Install dependencies
RUN npm install
RUN npm install -g serve
# Copy the application code to the container
COPY . .
RUN npm run build
# Expose port 80 for the application
EXPOSE 80

# Start the application
CMD ["serve", "-s", "build", "-p", "80"]

