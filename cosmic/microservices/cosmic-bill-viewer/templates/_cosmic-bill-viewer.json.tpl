{{- define "cosmic-bill-viewer.cosmic-bill-viewer.json" -}}
{
  "spring": {
    "application": {
      "name": "cosmic-bill-viewer"
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
