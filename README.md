# Mailhog

Since the official MailHog Docker image don't natively support M1 I needed a custom build for my setup. 

**Supported architectures**: `linux/arm64`, `linux/amd64`, `linux/amd64/v2`, `linux/ppc64le` & `linux/s390x`

## Docker hub
[https://hub.docker.com/r/tkwc/mailhog](https://hub.docker.com/r/tkwc/mailhog)

## What it does
Pull [golang:1.18-apline](https://hub.docker.com/layers/library/golang/1.18-alpine/images/sha256-ab5685692564e027aa84e2980855775b2e48f8fc82c1590c0e1e8cbc2e716542?context=explore) then install [MailHog:1.0.1](https://github.com/mailhog/MailHog/releases/tag/v1.0.1) from source. Finaly it fetch the [latest alpine](https://hub.docker.com/layers/library/alpine/latest/images/sha256-b6ca290b6b4cdcca5b3db3ffa338ee0285c11744b4a6abaa9627746ee3291d8d?context=explore) image and copy compiled MailHog to it to get the lighest image possible. It also fix a bug with boot2docker ([github issues #581](https://github.com/boot2docker/boot2docker/issues/581))

## Build, push and usage
### Build your own copy
If you want to build your own image and/or version, you can download this Dockerfile and modify it for your needs. You then have to type the following command: 

```bash
$ docker build -t tkwc/mailhog:<version> -t tkwc/mailhog:latest --platform linux/arm64,linux/amd64,linux/amd64/v2,linux/ppc64le,linux/s390x .
```

You should replace tkwc with your docker username and mailhog with your image name. You can also change the platform list depending on what's available on your system. To know what's the platform you can build for from your machine type:

```bash
$ docker buildx ls
```

### Publish your version
To publish your own version to docker hub, you'll need to type the following commands:

```bash
$ docker push tkwc/mailhog:<version>
$ docker push tkwc/mailhog:latest
```

Where you also changes tkwc with your username and mailhog with your new image name.

### Usage in docker compose

To use a custom image in your docker-compose.yml it's like using any other image, all you have to supply is the username and project published to docker hub. 

```yaml
version: "3"
services:
  mailhog:
    image: tkwc/mailhog
    ports:
      - "1025:1025" # smtp server
      - "8025:8025" # web ui
```

### Regular docker usage
Follow the docker run [documentation](https://docs.docker.com/engine/reference/commandline/run/) with the custom image specified:

```bash
$ docker run --rm --name my-container-name tkwc/mailhog
```

