FROM runatlantis/atlantis AS base

RUN wget https://github.com/gruntwork-io/terragrunt/releases/download/v0.28.24/terragrunt_linux_amd64 && chmod +x terragrunt_linux_amd64 && mv terragrunt_linux_amd64 /usr/bin/terragrunt

WORKDIR /home/atlantis

COPY --chown=atlantis:atlantis repos.yaml .

RUN apk add --no-cache python3

CMD ["server", "--repo-config=repos.yaml"]

FROM base AS azure

RUN \
  apk add py-pip && \
  apk add --virtual=build gcc libffi-dev musl-dev openssl-dev python3-dev make && \
  pip --no-cache-dir install -U pip && \
  pip install azure-cli && \
  apk del --purge build
