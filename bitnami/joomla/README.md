# Joomla!

[Joomla!](http://www.joomla.org/) is a PHP content management system (CMS) for publishing web content. It includes features such as page caching, RSS feeds, printable versions of pages, news flashes, blogs, search, and support for language international.

## TL;DR

```console
$ helm repo add bitnami https://charts.bitnami.com/bitnami
$ helm install my-release bitnami/joomla
```

## Introduction

This chart bootstraps a [Joomla!](https://github.com/bitnami/bitnami-docker-joomla) deployment on a [Kubernetes](http://kubernetes.io) cluster using the [Helm](https://helm.sh) package manager.

It also packages the [Bitnami MariaDB chart](https://github.com/kubernetes/charts/tree/master/bitnami/mariadb) which is required for bootstrapping a MariaDB deployment for the database requirements of the Joomla! application.

Bitnami charts can be used with [Kubeapps](https://kubeapps.com/) for deployment and management of Helm Charts in clusters. This chart has been tested to work with NGINX Ingress, cert-manager, fluentd and Prometheus on top of the [BKPR](https://kubeprod.io/).

## Prerequisites

- Kubernetes 1.12+
- Helm 2.12+ or Helm 3.0-beta3+
- PV provisioner support in the underlying infrastructure
- ReadWriteMany volumes for deployment scaling

## Installing the Chart

To install the chart with the release name `my-release`:

```console
$ helm install my-release bitnami/joomla
```

The command deploys Joomla! on the Kubernetes cluster in the default configuration. The [Parameters](#parameters) section lists the parameters that can be configured during installation.

> **Tip**: List all releases using `helm list`

## Uninstalling the Chart

To uninstall/delete the `my-release` deployment:

```console
$ helm delete my-release
```

The command removes all the Kubernetes components associated with the chart and deletes the release.

## Parameters

The following table lists the configurable parameters of the Joomla! chart and their default values per section/component:

### Global parameters

| Parameter                 | Description                                     | Default                                                 |
|---------------------------|-------------------------------------------------|---------------------------------------------------------|
| `global.imageRegistry`    | Global Docker image registry                    | `nil`                                                   |
| `global.imagePullSecrets` | Global Docker registry secret names as an array | `[]` (does not add image pull secrets to deployed pods) |
| `global.storageClass`     | Global storage class for dynamic provisioning   | `nil`                                                   |

### Common parameters

| Parameter           | Description                                                                  | Default                                                 |
|---------------------|------------------------------------------------------------------------------|---------------------------------------------------------|
| `image.registry`    | Joomla! image registry                                                       | `docker.io`                                             |
| `image.repository`  | Joomla! Image name                                                           | `bitnami/joomla`                                        |
| `image.tag`         | Joomla! Image tag                                                            | `{TAG_NAME}`                                            |
| `image.pullPolicy`  | Joomla! image pull policy                                                    | `IfNotPresent`                                          |
| `image.pullSecrets` | Specify docker-registry secret names as an array                             | `[]` (does not add image pull secrets to deployed pods) |
| `image.debug`       | Specify if debug logs should be enabled                                      | `false`                                                 |
| `nameOverride`      | String to partially override joomla.fullname template                        | `nil`                                                   |
| `fullnameOverride`  | String to fully override joomla.fullname template                            | `nil`                                                   |
| `commonLabels`      | Labels to add to all deployed objects                                        | `nil`                                                   |
| `commonAnnotations` | Annotations to add to all deployed objects                                   | `[]`                                                    |
| `extraDeploy`       | Array of extra objects to deploy with the release (evaluated as a template). | `nil`                                                   |

### Joomla! parameters

| Parameter                            | Description                                                                                                           | Default                                     |
|--------------------------------------|-----------------------------------------------------------------------------------------------------------------------|---------------------------------------------|
| `affinity`                           | Map of node/pod affinities                                                                                            | `{}`                                        |
| `allowEmptyPassword`                 | Allow DB blank passwords                                                                                              | `yes`                                       |
| `args`                               | Override default container args (useful when using custom images)                                                     | `nil`                                       |
| `command`                            | Override default container command (useful when using custom images)                                                  | `nil`                                       |
| `containerSecurityContext.enabled`   | Enable Joomla! containers' Security Context                                                                           | `true`                                      |
| `containerSecurityContext.runAsUser` | Joomla! containers' Security Context                                                                                  | `1001`                                      |
| `customLivenessProbe`                | Override default liveness probe                                                                                       | `nil`                                       |
| `customReadinessProbe`               | Override default readiness probe                                                                                      | `nil`                                       |
| `existingSecret`                     | Name of a secret with the application password                                                                        | `nil`                                       |
| `extraEnvVarsCM`                     | ConfigMap containing extra env vars                                                                                   | `nil`                                       |
| `extraEnvVarsSecret`                 | Secret containing extra env vars (in case of sensitive data)                                                          | `nil`                                       |
| `extraEnvVars`                       | Extra environment variables                                                                                           | `nil`                                       |
| `extraVolumeMounts`                  | Array of extra volume mounts to be added to the container (evaluated as template). Normally used with `extraVolumes`. | `nil`                                       |
| `extraVolumes`                       | Array of extra volumes to be added to the deployment (evaluated as template). Requires setting `extraVolumeMounts`    | `nil`                                       |
| `initContainers`                     | Add additional init containers to the pod (evaluated as a template)                                                   | `nil`                                       |
| `lifecycleHooks`                     | LifecycleHook to set additional configuration at startup Evaluated as a template                                      | ``                                          |
| `livenessProbe`                      | Liveness probe configuration                                                                                          | `Check values.yaml file`                    |
| `joomlaSkipInstall`                  | Skip joomla bootstrap (`no` / `yes`)                                                                                  | `no`                                        |
| `joomlaUsername`                     | User of the application                                                                                               | `user`                                      |
| `joomlaPassword`                     | Application password                                                                                                  | _random 10 character alphanumeric string_   |
| `joomlaEmail`                        | Admin email                                                                                                           | `user@example.com`                          |
| `nodeSelector`                       | Node labels for pod assignment                                                                                        | `{}` (The value is evaluated as a template) |
| `persistence.accessMode`             | PVC Access Mode for Joomla! volume                                                                                    | `ReadWriteOnce`                             |
| `persistence.enabled`                | Enable persistence using PVC                                                                                          | `true`                                      |
| `persistence.existingClaim`          | An Existing PVC name                                                                                                  | `nil`                                       |
| `persistence.hostPath`               | Host mount path for Joomla! volume                                                                                    | `nil` (will not mount to a host path)       |
| `persistence.size`                   | PVC Storage Request for Joomla! volume                                                                                | `8Gi`                                       |
| `persistence.storageClass`           | PVC Storage Class for Joomla! volume                                                                                  | `nil` (uses alpha storage class annotation) |
| `podAnnotations`                     | Pod annotations                                                                                                       | `{}`                                        |
| `podLabels`                          | Add additional labels to the pod (evaluated as a template)                                                            | `nil`                                       |
| `podSecurityContext.enabled`         | Enable Joomla! pods' Security Context                                                                                 | `true`                                      |
| `podSecurityContext.fsGroup`         | Joomla! pods' group ID                                                                                                | `1001`                                      |
| `readinessProbe`                     | Readiness probe configuration                                                                                         | `Check values.yaml file`                    |
| `replicaCount`                       | Number of Joomla! Pods to run                                                                                         | `1`                                         |
| `resources`                          | CPU/Memory resource requests/limits                                                                                   | Memory: `512Mi`, CPU: `300m`                |
| `sidecars`                           | Attach additional containers to the pod (evaluated as a template)                                                     | `nil`                                       |
| `smtpHost`                           | SMTP host                                                                                                             | `nil`                                       |
| `smtpPort`                           | SMTP port                                                                                                             | `nil` (but joomla internal default is 25)   |
| `smtpProtocol`                       | SMTP Protocol (options: ssl,tls, nil)                                                                                 | `nil`                                       |
| `smtpUser`                           | SMTP user                                                                                                             | `nil`                                       |
| `smtpPassword`                       | SMTP password                                                                                                         | `nil`                                       |
| `tolerations`                        | Tolerations for pod assignment                                                                                        | `[]` (The value is evaluated as a template) |
| `updateStrategy`                     | Deployment update strategy                                                                                            | `nil`                                       |

### Traffic Exposure Parameters

| Parameter                        | Description                           | Default        |
|----------------------------------|---------------------------------------|----------------|
| `service.type`                   | Kubernetes Service type               | `LoadBalancer` |
| `service.port`                   | Service HTTP port                     | `80`           |
| `service.httpsPort`              | Service HTTPS port                    | `443`          |
| `service.externalTrafficPolicy`  | Enable client source IP preservation  | `Cluster`      |
| `service.nodePorts.http`         | Kubernetes http node port             | `""`           |
| `service.nodePorts.https`        | Kubernetes https node port            | `""`           |
| `ingress.enabled`                | Enable ingress controller resource    | `false`        |
| `ingress.certManager`            | Add annotations for cert-manager      | `false`        |
| `ingress.hostname`               | Default host for the ingress resource | `joomla.local` |
| `ingress.annotations`            | Ingress annotations                   | `{}`           |
| `ingress.hosts[0].name`          | Hostname to your Joomla! installation | `nil`          |
| `ingress.hosts[0].path`          | Path within the url structure         | `nil`          |
| `ingress.tls[0].hosts[0]`        | TLS hosts                             | `nil`          |
| `ingress.tls[0].secretName`      | TLS Secret (certificates)             | `nil`          |
| `ingress.secrets[0].name`        | TLS Secret Name                       | `nil`          |
| `ingress.secrets[0].certificate` | TLS Secret Certificate                | `nil`          |
| `ingress.secrets[0].key`         | TLS Secret Key                        | `nil`          |

### Database parameters

| Parameter                                  | Description                              | Default                                        |
|--------------------------------------------|------------------------------------------|------------------------------------------------|
| `mariadb.enabled`                          | Whether to use the MariaDB chart         | `true`                                         |
| `mariadb.rootUser.password`                | MariaDB admin password                   | `nil`                                          |
| `mariadb.db.name`                          | Database name to create                  | `bitnami_joomla`                               |
| `mariadb.db.user`                          | Database user to create                  | `bn_joomla`                                    |
| `mariadb.db.password`                      | Password for the database                | _random 10 character long alphanumeric string_ |
| `mariadb.replication.enabled`              | MariaDB replication enabled              | `false`                                        |
| `mariadb.master.persistence.enabled`       | Enable database persistence using PVC    | `true`                                         |
| `mariadb.master.persistence.accessMode`    | Database Persistent Volume Access Modes  | `ReadWriteOnce`                                |
| `mariadb.master.persistence.size`          | Database Persistent Volume Size          | `8Gi`                                          |
| `mariadb.master.persistence.existingClaim` | Enable persistence using an existing PVC | `nil`                                          |
| `mariadb.master.persistence.storageClass`  | PVC Storage Class                        | `nil` (uses alpha storage class annotation)    |
| `mariadb.master.persistence.hostPath`      | Host mount path for MariaDB volume       | `nil` (will not mount to a host path)          |
| `externalDatabase.user`                    | Existing username in the external db     | `bn_joomla`                                    |
| `externalDatabase.password`                | Password for the above username          | `nil`                                          |
| `externalDatabase.database`                | Name of the existing database            | `bitnami_joomla`                               |
| `externalDatabase.host`                    | Host of the existing database            | `nil`                                          |
| `externalDatabase.port`                    | Port of the existing database            | `3306`                                         |

### Metrics parameters

| Parameter                   | Description                                      | Default                                                      |
|-----------------------------|--------------------------------------------------|--------------------------------------------------------------|
| `metrics.enabled`           | Start a side-car prometheus exporter             | `false`                                                      |
| `metrics.image.registry`    | Apache exporter image registry                   | `docker.io`                                                  |
| `metrics.image.repository`  | Apache exporter image name                       | `bitnami/apache-exporter`                                    |
| `metrics.image.tag`         | Apache exporter image tag                        | `{TAG_NAME}`                                                 |
| `metrics.image.pullPolicy`  | Image pull policy                                | `IfNotPresent`                                               |
| `metrics.image.pullSecrets` | Specify docker-registry secret names as an array | `[]` (does not add image pull secrets to deployed pods)      |
| `metrics.podAnnotations`    | Additional annotations for Metrics exporter pod  | `{prometheus.io/scrape: "true", prometheus.io/port: "9117"}` |
| `metrics.resources`         | Exporter resource requests/limit                 | {}                                                           |

The above parameters map to the env variables defined in [bitnami/joomla](http://github.com/bitnami/bitnami-docker-joomla). For more information please refer to the [bitnami/joomla](http://github.com/bitnami/bitnami-docker-joomla) image documentation.

Specify each parameter using the `--set key=value[,key=value]` argument to `helm install`. For example,

```console
$ helm install my-release \
  --set joomlaUsername=admin,joomlaPassword=password,mariadb.mariadbRootPassword=secretpassword \
    bitnami/joomla
```

The above command sets the Joomla! administrator account username and password to `admin` and `password` respectively. Additionally, it sets the MariaDB `root` user password to `secretpassword`.

Alternatively, a YAML file that specifies the values for the above parameters can be provided while installing the chart. For example,

```console
$ helm install my-release -f values.yaml bitnami/joomla
```

> **Tip**: You can use the default [values.yaml](values.yaml)

## Configuration and installation details

### [Rolling VS Immutable tags](https://docs.bitnami.com/containers/how-to/understand-rolling-tags-containers/)

It is strongly recommended to use immutable tags in a production environment. This ensures your deployment does not change automatically if the same tag is updated with a different image.

Bitnami will release a new chart updating its containers if a new version of the main container, significant changes, or critical vulnerabilities exist.

### Ingress without TLS

For using ingress (example without TLS):

```console
ingress.enabled=True
ingress.hosts[0]=joomla.domain.com
serviceType=ClusterIP
joomlaUsername=admin
joomlaPassword=password
mariadb.mariadbRootPassword=secretpassword
```

These are the *3 mandatory parameters* when *Ingress* is desired: `ingress.enabled=True`, `ingress.hosts[0]=joomla.domain.com` and `serviceType=ClusterIP`

### Ingress TLS

If your cluster allows automatic creation/retrieval of TLS certificates (e.g. [kube-lego](https://github.com/jetstack/kube-lego)), please refer to the documentation for that mechanism.

To manually configure TLS, first create/retrieve a key & certificate pair for the address(es) you wish to protect. Then create a TLS secret (named `joomla-server-tls` in this example) in the namespace. Include the secret's name, along with the desired hostnames, in the Ingress TLS section of your custom `values.yaml` file:

```yaml
ingress:
  ## If true, Joomla! server Ingress will be created
  ##
  enabled: true

  ## Joomla! server Ingress annotations
  ##
  annotations: {}
  #   kubernetes.io/ingress.class: nginx
  #   kubernetes.io/tls-acme: 'true'

  ## Joomla! server Ingress hostnames
  ## Must be provided if Ingress is enabled
  ##
  hosts:
    - joomla.domain.com

  ## Joomla! server Ingress TLS configuration
  ## Secrets must be manually created in the namespace
  ##
  tls:
    - secretName: joomla-server-tls
      hosts:
        - joomla.domain.com
```

## Persistence

The [Bitnami Joomla!](https://github.com/bitnami/bitnami-docker-joomla) image stores the Joomla! data and configurations at the `/bitnami/joomla` and `/bitnami/apache` paths of the container.

Persistent Volume Claims are used to keep the data across deployments. This is known to work in GCE, AWS, vpshere, and minikube.
See the [Parameters](#parameters) section to configure the PVC or to disable persistence.
You may want to review the [PV reclaim policy](https://kubernetes.io/docs/tasks/administer-cluster/change-pv-reclaim-policy/) and update as required. By default, it's set to delete, and when Joomla! is uninstalled, data is also removed.

## Upgrading

### To 8.0.0

The [Bitnami Joomla!](https://github.com/bitnami/bitnami-docker-joomla) image was migrated to a "non-root" user approach. Previously the container ran as the `root` user and the Apache daemon was started as the `daemon` user. From now on, both the container and the Apache daemon run as user `1001`. You can revert this behavior by setting the parameters `containerSecurityContext.runAsUser` to `root`.

Consequences:

- The HTTP/HTTPS ports exposed by the container are now `8080/8443` instead of `80/443`.
- Backwards compatibility is not guaranteed.

To upgrade to `7.0.0`, backup Joomla data and the previous MariaDB databases, install a new Joomla chart and import the backups and data, ensuring the `1001` user has the appropriate permissions on the migrated volume.

This upgrade also adapts the chart to the latest Bitnami good practices. Check the Parameters section for more information.

### To 7.0.0

Helm performs a lookup for the object based on its group (apps), version (v1), and kind (Deployment). Also known as its GroupVersionKind, or GVK. Changing the GVK is considered a compatibility breaker from Kubernetes' point of view, so you cannot "upgrade" those objects to the new GVK in-place. Earlier versions of Helm 3 did not perform the lookup correctly which has since been fixed to match the spec.

In https://github.com/helm/charts/pull/17299 the `apiVersion` of the deployment resources was updated to `apps/v1` in tune with the api's deprecated, resulting in compatibility breakage.

This major version signifies this change.

### To 3.0.0

Backwards compatibility is not guaranteed unless you modify the labels used on the chart's deployments.
Use the workaround below to upgrade from versions previous to 3.0.0. The following example assumes that the release name is opencart:

```console
$ kubectl patch deployment joomla-joomla --type=json -p='[{"op": "remove", "path": "/spec/selector/matchLabels/chart"}]'
$ kubectl delete statefulset joomla-mariadb --cascade=false
```
