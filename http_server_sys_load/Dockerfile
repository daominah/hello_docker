FROM golang:1.21.1-bookworm AS build-from-code

WORKDIR /app

COPY . /app
RUN go build -o /app/http_server_sys_load

# if Go test FAIL, docker build will fail too
RUN go test -v ./...



# deploy the application binary into a lean image:

FROM debian:bookworm AS copy-executable-binary

RUN apt-get update
RUN apt-get -qy install procps sysstat

WORKDIR /app
COPY --from=build-from-code /app/http_server_sys_load /app/http_server_sys_load
EXPOSE 21864
CMD ["/app/http_server_sys_load"]
