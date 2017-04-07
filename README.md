# Cosmic Microservices Chart

This repository contains the Helm chart for deploying the [Cosmic Microservices](https://github.com/MissionCriticalCloud/cosmic-microservices) into a Kubernetes.

For more information about installing and using Helm, see its
[README.md](https://github.com/kubernetes/helm/tree/master/README.md). To get a quick introduction to Charts see this [chart document](https://github.com/kubernetes/helm/blob/master/docs/charts.md).

## Installation
As this is not an official chart, deployment will need to be done by specifying the folder (path). For ease of documentation, following examples assume you execute the helm commands from within the checked out folder (specifying the path by `.`)

Pre-requirements:
- A running Cosmic installation (database) needs to be present, not only for metrics to be collected but also since the cosmic-usage-api needs to access the database for "path" (account) UUID-to-name translations.

- The namespace used for deployment, needs to already exist in kubernetes. The namespace is specified in the `values.yaml`.
To create the default namespace in kubernetes:
```bash
kubectl create namespace missioncriticalcloud
```

Standard deployment:
```bash
helm install .
```
This standard deployment will not generate an end-to-end working setup. To this end have a look at the [development bubble toolkit](https://github.com/MissionCriticalCloud/bubble-toolkit) setup.

Deployment used in our [development bubble toolkit](https://github.com/MissionCriticalCloud/bubble-toolkit)
```bash
helm install . --name=cosmic-release --set global.namespace=cosmic,global.registry=${MINIKUBE_HOST}:30081/,global.devMode=true --replace --wait
```
This deployment creates all required components, except for a running Cosmic installation.

See the [Helm help on install options](https://github.com/kubernetes/helm/blob/master/docs/helm/helm_install.md#options) for more information on the standard parameters.

### Special deployment values
The `values.yaml` file is used for passing options to the deployments. These options can be overridden from the command line by using the `--set` parameter. Most options are fairly self explanatory, such as information required to connect components together; usernames, passwords, hostnames, ports or container image tags.
The ones not so self explanatory (with default values):
- `global.devMode: false`: when changed to `true`, all required containers and test configurations will be created. When left to `false`, will not provision an elasticsearch and vault containers.
- `registry=`: Specifies the docker registry host to be used. An empty value refers to Docker hub, a value such as `${MINIKUBE_HOST}:30081/` refers to a local private registry. **As this string is simply prepended to the container image name, make sure you put a `/` at the end!**


## Upgrading
(Need some reference to upgrading with Helm)

### Experiences with upgrades

Upgrades are basically configuration changes, like a new version of a container image.

#### Revisions
With each change applied with Helm, the revision is incremented. Even with a rollback to a previous state (revision number), that "old" state will be implemented with an incremented version.

#### Restarting/loading of resources (e.g. pods)
A change to a (e.g.) deployment, specifically an actual value change in a deployment yaml file, will make the (re-)deployment recreate its resource. In the case of a deployment, will recreate the pod(s).

#### No implicit cascading reloading
When a change is made to a config map, the config map will be implemented, but will not recreate any pods which may have it mounted.

#### Removal of implemented deployments when removing defined deployments
For example when switching from `global.devMode: true` to `global.devMode: false`, the deployment for elasticsearch is not defined anymore. When "upgrading" this, Helm will remove the deployment.

## Chart format
The setup of this chart is possibly different from other charts; this is basically a single chart which deploy the set of deployments, services, secrets (and etc) for multiple applications. This is reflected in the `values.yaml` fileby the respective sections (an example):
```yaml
services:
  - cosmic-config-server
  - cosmic-usage-api

configmaps:
  - init-container-scripts
  - cosmic-vault-files

secrets:
  - cosmic-metrics-collector
  - cosmic-usage-api

deployments:
  - cosmic-metrics-collector
  - cosmic-usage-api
```
This is different to a standard chart, where only one application is deployed in a chart and dependent charts are either located in a `charts/` subfolder (one each), or specified in a the `requirements.yaml` file.

