{{- define "cosmic-billing-reporter.cosmic-billing-reporter.json" -}}
{
  "spring": {
    "application": {
      "name": "cosmic-billing-reporter"
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
