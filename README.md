# Cosmic Helm Repository

This repository contains [Helm](https://github.com/kubernetes/helm) charts.

For using these charts, add this repository to your helm repo configuration:
```bash
helm repo add cosmic http://cosmic-helm-repository.cosmiccloud.io.s3-website.eu-central-1.amazonaws.com
```

## Cosmic Charts

There are two collections of charts:
- [cosmic/microservices](cosmic/microservices): charts for the Cosmic Microservices
- [custom](custom): Supporting charts implementing 3rd party applications (e.g. RabbitMQ or LogStash)

The main reason for this repo is the implementation of cosmic-microservices, using the [cosmic-usage-chart](cosmic/microservices/cosmic-usage-chart)


## Building the repository

Eventually this will end up in Jenkins, for now the manual steps to update this Helm repo:

_(Assuming AWS SDK has been set up with proper credentials)_

When adding charts to the existing repo, first download the online `index.yaml` to extend the list of available packages:
```bash
aws s3 cp s3://cosmic-helm-repository.cosmiccloud.io/index.yaml repo/
```

From the root of the (this) cloned repository folder, execute `make`
```bash
make
```

Using the correct AWS configuration/credentials, upload the files to the repo:
```bash
cd repo
for i in *; do aws s3 cp $i s3://cosmic-helm-repository.cosmiccloud.io ; done
```
