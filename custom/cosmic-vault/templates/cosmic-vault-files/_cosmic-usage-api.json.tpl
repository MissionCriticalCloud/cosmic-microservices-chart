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
      "scan-interval": {{ .Values.cosmic.usageApi.scanInterval | quote }}
    },
    "usage-core": {
      "token-encryption-key": {{ .Values.cosmic.usageApi.tokenEncryptionKey | quote }},
      "token-encryption-salt": {{ .Values.cosmic.usageApi.tokenEncryptionSalt | quote }}
    }
  }
}
{{- end -}}
