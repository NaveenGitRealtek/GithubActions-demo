FROM golang:1.18 as builder
WORKDIR /app
COPY . .
RUN go mod init my-go-app
RUN go build -o my-go-app

FROM alpine:latest
WORKDIR /root/
COPY --from=builder /app/my-go-app .
CMD ["./my-go-app"]
