### Source code from https://hub.docker.com/r/anatomicjc/mailhog/tags

FROM golang:1.18-alpine as builder
ARG VERSION=1.0.1

# Install MailHog:
RUN apk --no-cache add --virtual build-dependencies \
    git gcc musl-dev \
  && mkdir -p /root/gocode \
  && export GOPATH=/root/gocode \
  && go install github.com/mailhog/MailHog@v${VERSION}

FROM alpine:latest

RUN apk upgrade --no-cache

# Add mailhog user/group with uid/gid 1000.
# This is a workaround for boot2docker issue #581, see
# https://github.com/boot2docker/boot2docker/issues/581
RUN apk upgrade --no-cache \
 && adduser -D -u 1000 mailhog

COPY --from=builder /root/gocode/bin/MailHog /usr/local/bin/

USER mailhog

WORKDIR /home/mailhog

ENTRYPOINT ["MailHog"]

# Expose the SMTP and HTTP ports:
EXPOSE 1025 8025

