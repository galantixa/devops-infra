FROM golang:1.18 as builder
ENV GO111MODULE=on
WORKDIR /app
COPY go.mod go.sum ./
RUN go mod download
COPY . .
RUN go build -o app
FROM gcr.io/distroless/base-debian11
COPY --from=builder /app/app /app/app
COPY .env /app/.env
ENV ENV_FILE_PATH=/app/.env
EXPOSE 5000
CMD ["/app/app"]