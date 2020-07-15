FROM daominah/go114

ENV APP_DIR=/go/src/app
RUN mkdir -p ${APP_DIR}
WORKDIR ${APP_DIR}
COPY ./example_app.go ./example_app.go
RUN go build -o app

EXPOSE 20891
CMD ["./app"]
