# Mailcatcher Docker-Image

Compact image to run mailcatcher for local development setups.

## Getting started

```bash
docker run --rm \
--name=mailcatcher \
--publish=1025:1025 \
--publish=1080:1080 \
quay.io/steigr/mailcatcher
```

## Configuration

The container accepts the following environment-variables:

* `MAILCATCHER_SMTP_PORT` (default: `1025`)
* `MAILCATCHER_HTTP_PORT` (default: `1080`)
* `MAILCATCHER_HTTP_PATH` (default: `/`)
* `MAILCATCHER_BROWSE` (default: `true`)
* `MAILCATCHER_VERBOSE` (default: `true`)
