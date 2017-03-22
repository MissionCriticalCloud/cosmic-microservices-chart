{{- define "configmaps.cosmic-vault-files.cosmic-metrics-collector.json" -}}
{
  "spring": {
    "datasource": {
      "url": "jdbc:mariadb://192.168.22.61:3306/cloud",
      "username": "cloud",
      "password": "cloud",
      "driver-class-name": "org.mariadb.jdbc.Driver"
    },
    "rabbitmq": {
      "host": "rabbitmq",
      "port": 5672,
      "username": "root",
      "password": "password"
    }
  },
  "cosmic": {
    "metrics-collector": {
      "scan-interval": "0 */15 * * * *",
      "broker-exchange": "cosmic-metrics-exchange",
      "broker-exchange-key": "cosmic-metrics-key"
    }
  }
}
{{- end -}}
