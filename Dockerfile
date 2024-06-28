# # Use the official Golang image as the base image
# FROM golang:1.18-alpine

# # Set the Current Working Directory inside the container
# WORKDIR /app

# # Copy go mod and sum files
# #COPY go.mod go.sum ./

# # Download all dependencies. Dependencies will be cached if the go.mod and go.sum files are not changed
# #RUN go mod download

# # Copy the source from the current directory to the Working Directory inside the container
# COPY . .

# # Build the Go app
# RUN go build -o main .

# # Expose port 8080 to the outside world
# #EXPOSE 8080

# # Command to run the executable
# CMD ["./main"]

# Use the official Golang image to create a build artifact.
# This is the build stage
FROM golang:1.18 AS builder

# Create and change to the app directory.
WORKDIR /app

# Copy go.mod and go.sum files if they exist
#COPY go.mod go.sum ./

# If go.mod doesn't exist, initialize it
#RUN if [ ! -f go.mod ]; then go mod init my-go-app; fi

# Download dependencies
#RUN go mod tidy

# Copy the source code into the container.
COPY . .

# Build the Go app
RUN go build -o main .

# # Use a smaller image for the final build
# FROM gcr.io/distroless/base-debian10

# # Copy the binary from the builder stage
# COPY --from=builder /app/main /main

# # Expose port 8080 to the outside world
# EXPOSE 8080

# Command to run the executable
CMD ["/main"]

