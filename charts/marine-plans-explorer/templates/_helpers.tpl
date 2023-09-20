{{/*
Expand the name of the chart.
*/}}
{{- define "marine-plans-explorer.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "marine-plans-explorer.fullname" -}}
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
{{- define "marine-plans-explorer.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "marine-plans-explorer.labels" -}}
helm.sh/chart: {{ include "marine-plans-explorer.chart" . }}
{{ include "marine-plans-explorer.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "marine-plans-explorer.selectorLabels" -}}
app.kubernetes.io/name: {{ include "marine-plans-explorer.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{/*
Create the name of the service account to use
*/}}
{{- define "marine-plans-explorer.serviceAccountName" -}}
{{- if .Values.serviceAccount.create }}
{{- default (include "marine-plans-explorer.fullname" .) .Values.serviceAccount.name }}
{{- else }}
{{- default "default" .Values.serviceAccount.name }}
{{- end }}
{{- end }}

{{/*
Get the password secret.
*/}}
{{- define "marine-plans-explorer.secretName" -}}
{{- if .Values.existingSecret -}}
    {{- printf "%s" (tpl .Values.existingSecret $) -}}
{{- else -}}
    {{- printf "%s" (include "marine-plans-explorer.fullname" .) -}}
{{- end -}}
{{- end -}}

{{/*
Return marine-plans-explorer password
*/}}
{{- define "marine-plans-explorer.password" -}}
{{- if .Values.mongoPassword -}}
    {{- .Values.mongoPassword -}}
{{- else -}}
    {{- randAlphaNum 10 -}}
{{- end -}}
{{- end -}}

{{/*
Return marine-plans-explorer apiKey
*/}}
{{- define "marine-plans-explorer.apiKey" -}}
    {{- .Values.apiKey -}}
{{- end -}}

{{/*
Return marine-plans-explorer webMapId
*/}}
{{- define "marine-plans-explorer.webMapId" -}}
    {{- .Values.webMapId -}}
{{- end -}}
