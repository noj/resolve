FROM --platform=$BUILDPLATFORM golang:1.23.3-bookworm AS build
WORKDIR /app
COPY go.mod go.sum ./
RUN go mod download
COPY . /app

ARG TARGETOS TARGETARCH
RUN GOOS=$TARGETOS GOARCH=$TARGETARCH CGO_ENABLED=0 go build -trimpath -ldflags '-w -s' -o resolve .

FROM --platform=$BUILDPLATFORM ubuntu:latest AS runtime
COPY --from=build /app/resolve /bin/resolve
ENTRYPOINT ["sh"]
