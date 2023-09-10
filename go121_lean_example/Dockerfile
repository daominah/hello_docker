# build the application from source:

FROM golang:1.21.1-bookworm AS build-from-code

WORKDIR /app
COPY go.mod go.sum /app/
RUN go mod download

COPY . /app
RUN go build -o /app/app_executable

# if Go test FAIL, docker build will fail too
RUN go test -v ./...



# deploy the application binary into a lean image:

FROM debian:bookworm AS copy-executable-binary
WORKDIR /app
COPY --from=build-from-code /app/app_executable /app/app_executable
EXPOSE 8888
CMD ["/app/app_executable"]
