# Use official Python image as base
FROM python:3.11-slim
# Set working directory inside container
WORKDIR /app
# Copy dependency file and install
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt
# Copy application code
COPY app.py .
# Expose app port
EXPOSE 5000
# Start the app
CMD ["python", "app.py"]

#===========

# Use official Nginx base image
FROM nginx:latest
# Copy custom HTML files into Nginx default path
COPY ./html /usr/share/nginx/html
# Expose port 80 for web traffic
EXPOSE 80
# Start Nginx (default command from base image)
CMD ["nginx", "-g", "daemon off;"]


# How to explain:
# FROM – base image (Python 3.11 slim for smaller size).
# WORKDIR – default folder for next commands.
# COPY requirements.txt + RUN pip install – install dependencies.
# COPY app.py – put our code into the image.
# EXPOSE 5000 – document that container listens on 5000.
# CMD [...] – default command when container starts.
# You can add:
# “To build and run: docker build -t demo-app . and docker run -p 5000:5000 demo-app.”


# ---------------------------
# Stage 1: Build the application
# ---------------------------
FROM node:18-alpine AS build
# Set working directory
WORKDIR /app
# Copy package files and install dependencies
COPY package*.json ./
RUN npm install
# Copy source code and build the app
COPY . .
RUN npm run build


# ---------------------------
# Stage 2: Serve using Nginx
# ---------------------------
FROM nginx:alpine
# Copy build output from Stage 1 to Nginx HTML folder
COPY --from=build /app/build /usr/share/nginx/html
# Expose port
EXPOSE 80
# Start Nginx
CMD ["nginx", "-g", "daemon off;"]


#========================
# Stage 1: Build JAR
FROM maven:3.9-eclipse-temurin-17 AS builder
WORKDIR /app
COPY pom.xml .
COPY src ./src
RUN mvn package -DskipTests

# Stage 2: Run JAR
FROM eclipse-temurin:17-jre
WORKDIR /app
COPY --from=builder /app/target/*.jar app.jar
EXPOSE 8080
CMD ["java", "-jar", "app.jar"]