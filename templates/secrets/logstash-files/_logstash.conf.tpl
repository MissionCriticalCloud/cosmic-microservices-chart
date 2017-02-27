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
    user => {{ .Values.rabbitmq.username | quote }}
    password => {{ .Values.rabbitmq.password | quote }}
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
    hosts => ["elasticsearch"]
    index => "cosmic-metrics-%{+YYYY.MM.dd}"
    document_type => "metric"
    codec => "json"
    manage_template => true
    template => "/config-dir/cosmic-metrics-template.json"
    template_name => "cosmic-metrics-template"
    template_overwrite => true
  }
}
{{- end -}}
