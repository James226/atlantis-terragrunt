FROM runatlantis/atlantis

RUN wget https://github.com/gruntwork-io/terragrunt/releases/download/v0.28.24/terragrunt_linux_amd64 && chmod +x terragrunt_linux_amd64 && mv terragrunt_linux_amd64 /usr/bin/terragrunt

WORKDIR /home/atlantis

COPY --chown=atlantis:atlantis repos.yaml .

RUN apt install -y python3

CMD ["server", "--repo-config=repos.yaml"]