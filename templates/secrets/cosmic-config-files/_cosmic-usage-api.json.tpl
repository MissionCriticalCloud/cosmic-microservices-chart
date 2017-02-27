{{- define "secrets.cosmic-config-files.cosmic-usage-api.json" -}}
{
  "spring": {
    "application": {
      "name": "cosmic-usage-api"
    },
    "cloud": {
      "config": {
        "uri": "http://cosmic-config-server:8080",
        "token": {{ .Values.cosmic_usage_api.vault_token | quote }}
      }
    }
  }
}
{{- end -}}
