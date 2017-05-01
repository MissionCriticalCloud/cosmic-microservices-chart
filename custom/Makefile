.PHONY: $(shell find * -type d)

all: clean cosmic-custom

cosmic-custom: cosmic-vault elasticsearch logstash rabbitmq grafana

cosmic-vault: build-cosmic-vault

elasticsearch: build-elasticsearch

logstash: build-logstash

rabbitmq: build-rabbitmq

grafana: build-grafana


build-%:
	if [ -f $*/requirements.yaml ]; then helm dep up $*; fi
	helm package $*

lint: lint-cosmic-vault lint-elasticsearch lint-logstash lint-rabbitmq lint-grafana
lint-%:
	helm lint $*

clean:
	find . -name "*.tgz" -exec rm '{}' +
