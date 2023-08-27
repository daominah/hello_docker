# build the application from source:

FROM golang:1.21.0-bookworm AS build-stage

WORKDIR /app
COPY go.mod go.sum /app/
RUN go mod download

COPY . /app
RUN go build -o /app/app_executable

# if Go test FAIL, docker build will fail too
RUN go test -v ./...



# deploy the application binary into a lean image:

FROM debian:bookworm AS executable-release-stage
WORKDIR /app
COPY --from=build-stage /app/app_executable /app/app_executable
EXPOSE 8888
CMD ["/app/app_executable"]
