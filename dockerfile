FROM golang:1.22-alpine as builder

WORKDIR /app

# Copy go.mod and go.sum files
COPY go.mod go.sum ./

# Download dependencies using go mod
RUN go mod download

# Copy the source code into the container
COPY . .

# Build the Go app (no need for GO111MODULE or GOPATH)
RUN go build -o main .

# Start a new stage from scratch
FROM alpine:latest

# Set environment variables
ENV PORT=8000

# Copy the pre-built binary file from the previous stage
COPY --from=builder /app/main /app/main

# Command to run the Go app
CMD ["/app/main"]
