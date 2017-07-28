{{- define "cosmic-vault.cosmic-vault-files.cosmic-bill-viewer.json" -}}
{
  "spring": {
    "mvc": {
      "static-path-pattern": "/public/**"
    },
    "mustache": {
      "suffix": ".mustache"
    }
  },
  "cosmic": {
    "bill-viewer": {
      "cosmic-api-base-url": "http://cosmic-usage-api:8080",
      "cpu-price": {{ .Values.cosmic.billViewer.cpuPrice }},
      "memory-price": {{ .Values.cosmic.billViewer.memoryPrice }},
      "storage-price": {{ .Values.cosmic.billViewer.storagePrice }},
      "public-ip-price": {{ .Values.cosmic.billViewer.publicIpPrice }},
      "service-fee": {{ .Values.cosmic.billViewer.serviceFee }},
      "innovation-fee": {{ .Values.cosmic.billViewer.innovationFee }}
    }
  }
}
{{- end -}}
