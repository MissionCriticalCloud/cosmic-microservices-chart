{{- define "cosmic-vault.cosmic-vault-files.cosmic-usage-api.json" -}}
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
          {{- range $index, $node := .Values.global.elasticsearch.clusterNodes -}}
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
      "scan-interval": {{ .Values.cosmicScanInterval | quote }}
    },
    "usage-core": {
      "token-encryption-key": {{ .Values.cosmicTokenEncryptionKey | quote }},
      "token-encryption-salt": {{ .Values.cosmicTokenEncryptionSalt | quote }},
      "token-encryption-ttl": {{ .Values.cosmicTokenEncryptionTtl | quote }}
    }
  }
}
{{- end -}}
