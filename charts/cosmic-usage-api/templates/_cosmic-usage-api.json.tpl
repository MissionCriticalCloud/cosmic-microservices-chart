{{- define "cosmic-usage-api.cosmic-usage-api.json" -}}
{
  "spring": {
    "application": {
      "name": "cosmic-usage-api"
    },
    "cloud": {
      "config": {
        "uri": "http://cosmic-config-server:8080",
        "token": {{ .Values.global.vault.readOnlyToken | quote }}
      }
    }
  }
}
{{- end -}}
