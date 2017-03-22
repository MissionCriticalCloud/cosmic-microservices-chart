{{- define "configmaps.cosmic-vault-files.cosmic-usage-api.json" -}}
{
  "spring": {
    "data": {
      "elasticsearch": {
        "cluster-nodes": "
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
      "scan-interval": "0 */15 * * * *"
    }
  }
}
{{- end -}}
