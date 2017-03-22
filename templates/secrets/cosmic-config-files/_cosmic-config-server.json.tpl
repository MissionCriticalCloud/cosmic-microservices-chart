{{- define "secrets.cosmic-config-files.cosmic-config-server.json" -}}
{
  "spring": {
    "cloud": {
      "config": {
        "server": {
          "vault": {
            "scheme": {{ .Values.vault.scheme | quote }},
            "host": {{ .Values.vault.host | quote }},
            "port": {{ .Values.vault.port }},
            "backend": {{ .Values.vault.backend | quote }}
          }
        }
      }
    }
  }
}
{{- end -}}
