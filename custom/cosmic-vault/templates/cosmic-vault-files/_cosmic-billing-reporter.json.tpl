{{- define "cosmic-vault.cosmic-vault-files.cosmic-billing-reporter.json" -}}
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
    },
    "mail": {
      "protocol": "smtp",
      "host": {{ .Values.cosmic.billingReporter.mailHost | quote }},
      "port": {{ .Values.cosmic.billingReporter.mailPort }},
      "username": {{ .Values.cosmic.billingReporter.mailUsername | quote }},
      "password": {{ .Values.cosmic.billingReporter.mailPassword | quote }}
    },
    "thymeleaf": {
      "prefix": "classpath:/mail/html/"
    }
  },
  "cosmic": {
    "usage-core": {
      "token-encryption-key": {{ .Values.cosmic.billingReporter.tokenEncryptionKey | quote }},
      "token-encryption-salt": {{ .Values.cosmic.billingReporter.tokenEncryptionSalt | quote }}
    },
    "billing-reporter": {
      "scan-interval": {{ .Values.cosmic.billingReporter.scanInterval | quote }},
      "bill-viewer-base-url": {{ .Values.cosmic.billingReporter.billViewerBaseUrl | quote }},
      "from-mail-address": {{ .Values.cosmic.billingReporter.fromEmailAddress | quote }},
      "token-ttl": {{ .Values.cosmic.billingReporter.tokenTtl }}
    }
  }
}
{{- end -}}
