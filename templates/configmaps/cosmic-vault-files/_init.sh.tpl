{{- define "configmaps.cosmic-vault-files.init.sh" -}}
#!/bin/sh
set -x

# Wait until Vault is up and running
until vault status; do sleep 1; done

vault write secret/cosmic-metrics-collector @/files/cosmic-metrics-collector.json
vault write secret/cosmic-usage-api @/files/cosmic-usage-api.json
{{- end -}}
