.PHONY: $(shell find * -type d)

all: clean cosmic-microservices

cosmic-microservices: cosmic-common cosmic-config-server cosmic-metrics-collector cosmic-usage-api cosmic-bill-viewer cosmic-usage-chart

cosmic-common: build-cosmic-common

cosmic-config-server: build-cosmic-config-server

cosmic-metrics-collector: build-cosmic-metrics-collector

cosmic-usage-api: build-cosmic-usage-api

cosmic-bill-viewer: build-cosmic-bill-viewer

cosmic-usage-chart: cosmic-common cosmic-config-server cosmic-metrics-collector cosmic-usage-api cosmic-bill-viewer
cosmic-usage-chart: build-cosmic-usage-chart


build-%:
	if [ -f $*/requirements.yaml ]; then helm dep up $*; fi
	helm package $*

lint: lint-cosmic-common lint-cosmic-config-server lint-cosmic-metrics-collector lint-cosmic-usage-api lint-cosmic-bill-viewer lint-cosmic-usage-chart
lint-%:
	helm lint $*

clean:
	find . -name "*.tgz" -exec rm '{}' +
