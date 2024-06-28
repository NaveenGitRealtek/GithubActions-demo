# Use the official Golang image to build the app
FROM golang:1.18 as builder

# Set the working directory inside the container
WORKDIR /app

# Copy go mod and sum files
#COPY go.mod go.sum ./

# Download all dependencies
#RUN go mod download

# Copy the source code
COPY . .

# Build the application
RUN go build -o my-go-app main.go

# Expose the port the app runs on
#EXPOSE 8080

# Command to run the executable
CMD ["./my-go-app1"]



