# Stage 1: Build the Go app
FROM golang:1.23-alpine AS base

# Set the working directory inside the container
WORKDIR /app

# Copy the Go module files and download the necessary Go dependencies
COPY go.mod ./
RUN go mod download

# Copy the entire source code to the container
COPY . .

# Build the Go app. Adjust `main.go` to the entry point of your app
RUN go build -o main .

# Stage 2: Create a lightweight image for running the app
FROM gcr.io/distroless/base


COPY --from=base /app/main .
COPY --from=base /app/static ./static

# Expose the necessary port (for example, if your Go app runs on port 8080)
EXPOSE 8080

# Command to run the Go app
CMD ["./main"]
