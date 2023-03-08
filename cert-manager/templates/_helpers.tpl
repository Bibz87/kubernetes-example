{{/*
Get a service account's token secret name
*/}}
{{- define "token.secret.name" -}}
{{ print . "-token" | quote }}
{{- end }}
