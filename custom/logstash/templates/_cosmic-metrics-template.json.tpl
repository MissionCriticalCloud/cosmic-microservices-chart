{{- define "logstash.cosmic-metrics-template.json" -}}
{
  "order": 0,
  "template": "cosmic-metrics-*",
  "settings": {
    "index": {
      "refresh_interval": "5s"
    }
  },
  "mappings": {
    "_default_": {
      "dynamic_templates": [
        {
          "strings": {
            "match": "*",
            "match_mapping_type": "string",
            "mapping": {
              "type": "string",
              "index": "not_analyzed"
            }
          }
        }
      ],
      "_all": {
        "enabled": false
      },
      "properties": {
        "@timestamp": {
          "type": "date",
          "format": "strict_date_optional_time||epoch_millis"
        },
        "payload": {
          "properties": {
            "memory": {
              "type": "double"
            },
            "cpu": {
              "type": "double"
            },
            "size": {
              "type": "double"
            }
          }
        }
      }
    }
  }
}
{{- end -}}
