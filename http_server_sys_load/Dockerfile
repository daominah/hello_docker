FROM golang:1.21.1-bookworm AS build-from-code

WORKDIR /app

COPY . /app
RUN go build -o /app/http_server_sys_load

# if Go test FAIL, docker build will fail too
RUN go test -v ./...



# deploy the application binary into a lean image:

FROM debian:bookworm AS executable-release-stage
WORKDIR /app
COPY --from=build-stage /app/http_server_sys_load /app/http_server_sys_load
EXPOSE 8888
CMD ["/app/http_server_sys_load"]
