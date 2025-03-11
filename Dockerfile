FROM golang:1.23 as build

WORKDIR /app

# Copy go.mod and go.sum files
COPY go.mod .
# Download Go dependencies
RUN go mod download

# Copy the rest of the application code
COPY . .

# Build the Go application
RUN go build -o main .

FROM gcr.io/distroless/base

COPY --from=build /app/main .

COPY --from=build /app/static ./static

Expose 8081

CMD ["./main"]
