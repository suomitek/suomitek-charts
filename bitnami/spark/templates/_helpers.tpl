{{- /* vim: set filetype=mustache: */}}
{{- /*
Expand the name of the chart.
*/}}
{{- define "spark.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
Return the proper Spark image name
*/}}
{{- define "spark.image" -}}
{{- $registryName := .Values.image.registry -}}
{{- $repositoryName := .Values.image.repository -}}
{{- $tag := .Values.image.tag | toString -}}
{{/*
Helm 2.11 supports the assignment of a value to a variable defined in a different scope,
but Helm 2.9 and 2.10 doesn't support it, so we need to implement this if-else logic.
Also, we can't use a single if because lazy evaluation is not an option
*/}}
{{- if .Values.global }}
    {{- if .Values.global.imageRegistry }}
        {{- printf "%s/%s:%s" .Values.global.imageRegistry $repositoryName $tag -}}
    {{- else -}}
        {{- printf "%s/%s:%s" $registryName $repositoryName $tag -}}
    {{- end -}}
{{- else -}}
    {{- printf "%s/%s:%s" $registryName $repositoryName $tag -}}
{{- end -}}
{{- end -}}


{{- /*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "spark.fullname" -}}
{{- if .Values.fullnameOverride -}}
{{- .Values.fullnameOverride | trunc 63 | trimSuffix "-" -}}
{{- else -}}
{{- $name := default .Chart.Name .Values.nameOverride -}}
{{- if contains $name .Release.Name -}}
{{- .Release.Name | trunc 63 | trimSuffix "-" -}}
{{- else -}}
{{- printf "%s-%s" .Release.Name $name | trunc 63 | trimSuffix "-" -}}
{{- end -}}
{{- end -}}
{{- end -}}

{{- /* 
As we use a headless service we need to append -master-svc to 
the service name. 
*/ -}}
{{- define "spark.master.service.name" -}}
{{ include "spark.fullname" . }}-master-svc
{{- end -}}

{{- /*
Create chart name and version as used by the chart label.
*/}}
{{- define "spark.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
Common labels
*/}}
{{- define "spark.labels" -}}
app.kubernetes.io/name: {{ include "spark.name" . }}
helm.sh/chart: {{ include "spark.chart" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end -}}

{{/*
Labels to use on deploy.spec.selector.matchLabels and svc.spec.selector
*/}}
{{- define "spark.matchLabels" -}}
app.kubernetes.io/name: {{ include "spark.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end -}}

{{- define "spark.imagePullSecrets" -}}
{{/*
Helm 2.11 supports the assignment of a value to a variable defined in a different scope,
but Helm 2.9 and 2.10 does not support it, so we need to implement this if-else logic.
Also, we can not use a single if because lazy evaluation is not an option
*/}}
{{- if .Values.global }}
{{- if .Values.global.imagePullSecrets }}
imagePullSecrets:
{{- range .Values.global.imagePullSecrets }}
  - name: {{ . }}
{{- end }}
{{- else if .Values.image.pullSecrets }}
imagePullSecrets:
{{- range .Values.image.pullSecrets }}
  - name: {{ . }}
{{- end }}
{{- end -}}
{{- else if .Values.image.pullSecrets }}
imagePullSecrets:
{{- range .Values.image.pullSecrets }}
  - name: {{ . }}
{{- end }}
{{- end -}}
{{- end -}}

{{/* Validate values of Spark - Incorrect extra volume settings */}}
{{- define "spark.validateValues.extraVolumes" -}}
{{- if and (.Values.worker.extraVolumes) (not .Values.worker.extraVolumeMounts) -}}
spark: missing-worker-extra-volume-mounts
    You specified worker extra volumes but no mount points for them. Please set
    the extraVolumeMounts value
{{- end -}}
{{- end -}}


{{/*
Compile all warnings into a single message, and call fail.
*/}}
{{- define "spark.validateValues" -}}
{{- $messages := list -}}
{{- $messages := append $messages (include "spark.validateValues.extraVolumes" .) -}}
{{- $messages := append $messages (include "spark.validateValues.workerCount" .) -}}
{{- $messages := without $messages "" -}}
{{- $message := join "\n" $messages -}}

{{- if $message -}}
{{-   printf "\nVALUES VALIDATION:\n%s" $message | fail -}}
{{- end -}}
{{- end -}}

{/* Validate values of Spark - number of workers must be greater than 0 */}}
{{- define "spark.validateValues.workerCount" -}}
{{- $replicaCount := int .Values.worker.replicaCount }}
{{- if lt $replicaCount 1 -}}
spark: workerCount
    Worker replicas must be greater than 0!!
    Please set a valid worker count size (--set worker.replicaCount=X)
{{- end -}}
{{- end -}}


{{/* Get the secret for paswords */}}
{{- define "spark.get.passwordSecretName" -}}
{{- if .Values.security.passwordsSecretName -}}
  {{- printf "%s" .Values.security.passwordsSecretName -}}
{{- else }}
  {{- printf "%s-secret" (include "spark.fullname" .) -}}
{{- end }}
{{- end -}}

{{/* Warning for rolling tags */}}
{{- define "spark.rollingTags.warning" -}}
{{- if and (contains "bitnami/" .Values.image.repository) (not (.Values.image.tag | toString | regexFind "-r\\d+$|sha256:")) }}
WARNING: Rolling tag detected ({{ .Values.image.repository }}:{{ .Values.image.tag }}), please note that it is strongly recommended to avoid using rolling tags in a production environment.
+info https://docs.bitnami.com/containers/how-to/understand-rolling-tags-containers/
{{- end -}}
{{- end -}}

{{/*
Renders a value that contains template.
Usage:
{{ include "spark.tplValue" (dict "value" .Values.path.to.the.Value "context" $) }}
*/}}
{{- define "spark.tplValue" -}}
    {{- if typeIs "string" .value }}
        {{- tpl .value .context }}
    {{- else }}
        {{- tpl (.value | toYaml) .context }}
    {{- end }}
{{- end -}}
