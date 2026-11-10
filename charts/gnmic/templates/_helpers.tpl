{{/*
Expand the name of the chart.
*/}}
{{- define "gnmic.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "gnmic.fullname" -}}
{{- if .Values.fullnameOverride }}
{{- .Values.fullnameOverride | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- $name := default .Chart.Name .Values.nameOverride }}
{{- if contains $name .Release.Name }}
{{- .Release.Name | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- printf "%s-%s" .Release.Name $name | trunc 63 | trimSuffix "-" }}
{{- end }}
{{- end }}
{{- end }}

{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "gnmic.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "gnmic.labels" -}}
helm.sh/chart: {{ include "gnmic.chart" . }}
{{ include "gnmic.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "gnmic.selectorLabels" -}}
app.kubernetes.io/name: {{ include "gnmic.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{/*
Create the name of the service account to use
*/}}
{{- define "gnmic.serviceAccountName" -}}
{{- if .Values.serviceAccount.create }}
{{- default (include "gnmic.fullname" .) .Values.serviceAccount.name }}
{{- else }}
{{- default "default" .Values.serviceAccount.name }}
{{- end }}
{{- end }}

{{/*
API version for the Strimzi (KafkaTopic, KafkaUser) resources.
The kafka.strimzi.io/v1 API is only served by Strimzi >= 0.49, while older operators serve only
kafka.strimzi.io/v1beta2, which Strimzi 1.0 removes. Use v1 when the cluster serves it and fall back
to v1beta2 otherwise, so the chart works on both. When Helm cannot discover the API versions (for
example with "helm template" without --api-versions) the fallback is v1beta2.
This can be hard-coded to kafka.strimzi.io/v1 once Strimzi >= 1.0 is everywhere.
*/}}
{{- define "gnmic.strimzi.apiVersion" -}}
{{- if .Capabilities.APIVersions.Has "kafka.strimzi.io/v1" -}}
kafka.strimzi.io/v1
{{- else -}}
kafka.strimzi.io/v1beta2
{{- end -}}
{{- end }}
