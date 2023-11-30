{{/*
Expand the name of the chart.
*/}}
{{- define "spatial-climate-impact.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "spatial-climate-impact.fullname" -}}
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
{{- define "spatial-climate-impact.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "spatial-climate-impact.labels" -}}
helm.sh/chart: {{ include "spatial-climate-impact.chart" . }}
{{ include "spatial-climate-impact.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "spatial-climate-impact.selectorLabels" -}}
app.kubernetes.io/name: {{ include "spatial-climate-impact.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{/*
Create the name of the service account to use
*/}}
{{- define "spatial-climate-impact.serviceAccountName" -}}
{{- if .Values.serviceAccount.create }}
{{- default (include "spatial-climate-impact.fullname" .) .Values.serviceAccount.name }}
{{- else }}
{{- default "default" .Values.serviceAccount.name }}
{{- end }}
{{- end }}

{{/*
Get the password secret.
*/}}
{{- define "spatial-climate-impact.secretName" -}}
{{- if .Values.existingSecret -}}
    {{- printf "%s" (tpl .Values.existingSecret $) -}}
{{- else -}}
    {{- printf "%s" (include "spatial-climate-impact.fullname" .) -}}
{{- end -}}
{{- end -}}

{{/*
Return spatial-climate-impact password
*/}}
{{- define "spatial-climate-impact.password" -}}
{{- if .Values.mongoPassword -}}
    {{- .Values.mongoPassword -}}
{{- else -}}
    {{- randAlphaNum 10 -}}
{{- end -}}
{{- end -}}

{{/*
Return spatial-climate-impact apiKey
*/}}
{{- define "spatial-climate-impact.apiKey" -}}
    {{- .Values.apiKey -}}
{{- end -}}

{{/*
Return spatial-climate-impact webMapId
*/}}
{{- define "spatial-climate-impact.webMapId" -}}
    {{- .Values.webMapId -}}
{{- end -}}

{{/*
Return spatial-climate-impact googleAnalyticsId
*/}}
{{- define "spatial-climate-impact.googleAnalyticsId" -}}
    {{- .Values.googleAnalyticsId -}}
{{- end -}}

{{/*
Return spatial-climate-impact nextAuthSecret
*/}}
{{- define "spatial-climate-impact.nextAuthSecret" -}}
    {{- .Values.nextAuthSecret -}}
{{- end -}}
