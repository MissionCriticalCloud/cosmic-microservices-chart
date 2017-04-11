{{- define "cosmic-config-server.cosmic-config-server.json" -}}
{
  "spring": {
    "cloud": {
      "config": {
        "server": {
          "vault": {
            "scheme": {{ .Values.global.vault.scheme | quote }},
            "host": {{ .Values.global.vault.host | quote }},
            "port": {{ .Values.global.vault.port }},
            "backend": {{ .Values.global.vault.backend | quote }}
          }
        }
      }
    }
  }
}
{{- end -}}
