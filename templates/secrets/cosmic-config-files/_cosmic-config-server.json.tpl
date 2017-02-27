{{- define "secrets.cosmic-config-files.cosmic-config-server.json" -}}
{
  "spring": {
    "cloud": {
      "config": {
        "server": {
          "vault": {
            "scheme": {{ .Values.cosmic_config_server.vault.scheme | quote }},
            "host": {{ .Values.cosmic_config_server.vault.host | quote }},
            "port": {{ .Values.cosmic_config_server.vault.port }},
            "backend": {{ .Values.cosmic_config_server.vault.backend | quote }}
          }
        }
      }
    }
  }
}
{{- end -}}
