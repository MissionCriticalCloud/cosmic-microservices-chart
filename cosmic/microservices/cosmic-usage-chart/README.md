# Cosmic Usage Chart

This repository contains the Helm chart for deploying the [Cosmic Microservices](https://github.com/MissionCriticalCloud/cosmic-microservices) into a Kubernetes.

For more information about installing and using Helm, see its
[README.md](https://github.com/kubernetes/helm/tree/master/README.md). To get a quick introduction to Charts see this [chart document](https://github.com/kubernetes/helm/blob/master/docs/charts.md).

## Installation
This chart is hosted as a fully functional Helm chart. Add the Cosmic repo to Helm for deployment:
```bash
helm repo add cosmic http://cosmic-helm-repository.cosmiccloud.io.s3-website.eu-central-1.amazonaws.com
```

Pre-requirements:
- A running Cosmic installation (database) needs to be present, not only for metrics to be collected but also since the cosmic-usage-api needs to access the database for "path" (account) UUID-to-name translations.

- The namespace used for deployment, needs to already exist in kubernetes. The namespace is specified in the `values.yaml`.
To create the default namespace in kubernetes:
```bash
kubectl create namespace missioncriticalcloud
```

Standard deployment:
```bash
helm install cosmic/cosmic-usage-chart 
```
This standard deployment will not generate an end-to-end working setup. To this end have a look at the [development bubble toolkit](https://github.com/MissionCriticalCloud/bubble-toolkit) setup.

Deployment used in our [development bubble toolkit](https://github.com/MissionCriticalCloud/bubble-toolkit)
```bash
helm install cosmic/cosmic-usage-chart --name=cosmic-release --set global.namespace=cosmic,global.registry=${MINIKUBE_HOST}:30081/,global.devMode=true --replace --wait
```
This deployment creates all required components, except for a running Cosmic installation.

See the [Helm help on install options](https://github.com/kubernetes/helm/blob/master/docs/helm/helm_install.md#options) for more information on the standard parameters.

### Special deployment values
The `values.yaml` file is used for passing options to the deployments. These options can be overridden from the command line by using the `--set` parameter. Most options are fairly self explanatory, such as information required to connect components together; usernames, passwords, hostnames, ports or container image tags.
The ones not so self explanatory (with default values):
- `global.devMode: false`: when changed to `true`, all required containers and test configurations will be created. When left to `false`, will not provision an elasticsearch and vault containers.
- `global.registry=`: Specifies the docker registry host to be used. An empty value refers to Docker hub, a value such as `${MINIKUBE_HOST}:30081/` refers to a local private registry. **As this string is simply prepended to the container image name, make sure you put a `/` at the end!**


## Upgrading
(Need some reference to upgrading with Helm)

Following through on the example of the install in the development bubble toolkit, an upgrade would be started by the following command:
```bash
helm upgrade cosmic-release cosmic/cosmic-usage-chart --set global.namespace=cosmic,global.registry=${MINIKUBE_HOST}:30081/,global.devMode=true --wait
```


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
The setup of this chart is slightly different from other charts; this chart itself depends entirely on other charts. For now they are all located within the `charts/` subfolder in this repo. This alone will already ensure that they will be loaded. All of the charts are also mentioned in the `requirements.yaml` file wich specifies explicitly the dependencies, but also conditions for charts (_not_) to be loaded.
 
### Experiences with Charts
The [Helm repository contains a useful documentation section](https://github.com/kubernetes/helm/blob/master/docs/index.md). Some additional information or experiences specific to this chart:

#### Global values
Some data is shared among several charts. This is specified in the global `values.yaml` file under the `global:` section. 

See [Helm documentation on Global Values](https://github.com/kubernetes/helm/blob/master/docs/chart_template_guide/subcharts_and_globals.md) for more information. 

#### YAML anchors, references and overriding values
The (processing of the) YAML files support anchors and references. It should be noted that overriding attributes takes place after the YAML has been processed. Following example was an attempt to set (default) values for multiple (sub)charts. Setting the defaults will work, but they (subsections/charts) can not be effectively overridden using that default section:

```yaml
shared: &SHARE
 someItem: someValue

exampleChart: 
  <<: *SHARE
  anotherItem: anotherValue
```
Results in:
```yaml
shared:
 someItem: someValue

exampleChart: 
  someItem: someValue
  anotherItem: anotherValue
```
Calling Helm with override parameter (`--set shared.someItem=ultimateValue`), results in:
```yaml
shared:
 someItem: ultimateValue

exampleChart: 
  someItem: someValue
  anotherItem: anotherValue
```
