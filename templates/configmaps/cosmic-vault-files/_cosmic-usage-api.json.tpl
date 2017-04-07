{{- define "configmaps.cosmic-vault-files.cosmic-usage-api.json" -}}
{
  "spring": {
    "datasource": {
      "url": "jdbc:mariadb://192.168.22.61:3306/cloud",
      "username": "cloud",
      "password": "cloud",
      "driver-class-name": "org.mariadb.jdbc.Driver"
    },
    "elasticsearch": {
      "jest": {
        "uris": "
          {{- range $index, $node := .Values.elasticsearch.cluster_nodes -}}
            {{- if $index -}}
              ,
            {{- end -}}
            {{- $node -}}
          {{- end -}}
        "
      }
    }
  },
  "cosmic": {
    "usage-api": {
      "scan-interval": {{ .Values.cosmic_vault.cosmic_scan_interval | quote }}
    }
  }
}
{{- end -}}
