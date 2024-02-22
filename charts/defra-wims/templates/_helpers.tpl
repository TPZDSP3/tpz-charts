{{/*
Expand the name of the chart.
*/}}
{{- define "defra-wims.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "defra-wims.fullname" -}}
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
{{- define "defra-wims.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "defra-wims.labels" -}}
helm.sh/chart: {{ include "defra-wims.chart" . }}
{{ include "defra-wims.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "defra-wims.selectorLabels" -}}
app.kubernetes.io/name: {{ include "defra-wims.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{/*
Create the name of the service account to use
*/}}
{{- define "defra-wims.serviceAccountName" -}}
{{- if .Values.serviceAccount.create }}
{{- default (include "defra-wims.fullname" .) .Values.serviceAccount.name }}
{{- else }}
{{- default "default" .Values.serviceAccount.name }}
{{- end }}
{{- end }}

{{/*
Get the sealed secrets.
*/}}
{{- define "defra-wims.secretName" -}}
{{- if .Values.existingSecret -}}
    {{- printf "%s" (tpl .Values.existingSecret $) -}}
{{- else -}}
    {{- printf "%s" (include "defra-wims.fullname" .) -}}
{{- end -}}
{{- end -}}

{{/*
Return defra-wims awsAccessKeyId
*/}}
{{- define "defra-wims.awsAccessKeyId" -}}
    {{- .Values.processor.aws.awsAccessKeyId -}}
{{- end -}}

{{/*
Return defra-wims awsSecretAccessKey
*/}}
{{- define "defra-wims.awsSecretAccessKey" -}}
    {{- .Values.processor.aws.awsSecretAccessKey -}}
{{- end -}}
