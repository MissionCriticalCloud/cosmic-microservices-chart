{{- define "secrets.logstash-files.logstash.conf" -}}
input {
  rabbitmq {
    host => "rabbitmq"
    port => 5672
    exchange => "cosmic-metrics-exchange"
    exchange_type => "direct"
    queue => "cosmic-metrics-queue"
    durable => true
    exclusive => false
    key => "cosmic-metrics-key"
    user => {{ .Values.global.rabbitmq.username | quote }}
    password => {{ .Values.global.rabbitmq.password | quote }}
    codec => "json"
  }
}

filter {
  mutate {
    remove_field => ["@version"]
  }
}

output {
  elasticsearch {
    hosts => [
      {{- range $index, $node := .Values.global.elasticsearch.cluster_nodes -}}
        {{- if $index -}}
          ,
        {{- end -}}
        {{- $node | quote -}}
      {{- end -}}
    ]
    index => "cosmic-metrics-%{+YYYY.MM.dd}"
    document_type => "metric"
    codec => "json"
    manage_template => true
    template => "/files/cosmic-metrics-template.json"
    template_name => "cosmic-metrics-template"
    template_overwrite => true
  }
}
{{- end -}}
