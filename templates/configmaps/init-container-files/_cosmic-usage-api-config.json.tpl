{{- define "configmaps.init-container-files.cosmic-usage-api-config.json" -}}
{
  "spring": {
    "data": {
      "elasticsearch": {
        "cluster-nodes": "elasticsearch:9300"
      }
    }
  },
  "cosmic": {
    "usage-api": {
      "scan-interval": "0 */15 * * * *"
    }
  }
}
{{- end -}}
