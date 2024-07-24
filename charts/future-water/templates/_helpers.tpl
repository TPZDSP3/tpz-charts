{{/*
Expand the name of the chart.
*/}}
{{- define "future-water.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "future-water.fullname" -}}
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
{{- define "future-water.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "future-water.labels" -}}
helm.sh/chart: {{ include "future-water.chart" . }}
{{ include "future-water.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "future-water.selectorLabels" -}}
app.kubernetes.io/name: {{ include "future-water.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{/*
Create the name of the service account to use
*/}}
{{- define "future-water.serviceAccountName" -}}
{{- if .Values.serviceAccount.create }}
{{- default (include "future-water.fullname" .) .Values.serviceAccount.name }}
{{- else }}
{{- default "default" .Values.serviceAccount.name }}
{{- end }}
{{- end }}

{{/*
Get the password secret.
*/}}
{{- define "future-water.secretName" -}}
{{- if .Values.existingSecret -}}
    {{- printf "%s" (tpl .Values.existingSecret $) -}}
{{- else -}}
    {{- printf "%s" (include "future-water.fullname" .) -}}
{{- end -}}
{{- end -}}

{{/*
Return future-water googleAnalyticsId
*/}}
{{- define "future-water.googleAnalyticsId" -}}
    {{- .Values.googleAnalyticsId -}}
{{- end -}}

{{/*
Return future-water mapboxToken
*/}}
{{- define "future-water.mapboxToken" -}}
    {{- .Values.mapboxToken -}}
{{- end -}}
