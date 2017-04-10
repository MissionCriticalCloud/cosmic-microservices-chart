{{- define "cosmic-metrics-collector.cosmic-metrics-collector.json" -}}
{
  "spring": {
    "application": {
      "name": "cosmic-metrics-collector"
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
