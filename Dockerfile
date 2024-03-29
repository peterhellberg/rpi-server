FROM balenalib/raspberrypi3-alpine-golang:1.19-3.15 as builder
WORKDIR /go/src/rpi-server
COPY . ./
RUN apk add musl-dev linux-headers
RUN apk --no-cache add ca-certificates \
  && update-ca-certificates
RUN go install -a -tags netgo -ldflags '-extldflags "-static"'

FROM resin/scratch
COPY --from=builder /etc/ssl/certs/ca-certificates.crt /etc/ssl/certs/
COPY --from=builder /go/bin/rpi-server /rpi-server
CMD ["/rpi-server"]
