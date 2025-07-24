# Stage 1: Build the application
FROM node:16-slim AS builder

# Set the working directory
WORKDIR /app

# Copy package files first to leverage Docker cache
COPY package*.json ./

# Install dependencies (including dev dependencies)
RUN npm install

# Copy the rest of the application code
COPY . .

# Build the React app
RUN npm run build

# Stage 2: Production runtime
FROM node:16-slim

# Set the working directory
WORKDIR /app

# Install only production dependencies
COPY package*.json ./
RUN npm install --only=production

# Copy built assets from builder stage
COPY --from=builder /app/build ./build
COPY --from=builder /app/public ./public
COPY --from=builder /app/src ./src

# Copy any other necessary files (like server.js if you have one)
# COPY server.js ./

# Expose port 3000
EXPOSE 3000

# Start your Node.js server
CMD ["npm", "start"]