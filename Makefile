.PHONY: $(shell find * -type d)

MAKE_DIR    = $(PWD)
DOC_DIR    := $(MAKE_DIR)/repo
INDEX_YAML  = repo/index.yaml

ifneq ("$(wildcard $(INDEX_YAML))","")
MERGE_YAML := --merge $(INDEX_YAML)
endif

all: clean lint package

package: build collect index

build: cosmic-microservices cosmic-custom

cosmic-microservices: cosmic-custom
	@$(MAKE) -C cosmic/microservices

cosmic-custom:
	@$(MAKE) -C custom

lint: lint-cosmic-microservices

lint-cosmic-microservices: lint-cosmic-custom
	@$(MAKE) -C cosmic/microservices lint

lint-cosmic-custom:
	@$(MAKE) -C custom lint

collect:
	find . -name "*.tgz" ! -path '*/charts/*' ! -path '$(DOC_DIR)/*' -exec mv -f -t $(DOC_DIR)/ '{}' +

index:
	helm repo index repo --url http://cosmic-helm-repository.cosmiccloud.io.s3-website.eu-central-1.amazonaws.com $(MERGE_YAML)

clean:
	find . -name "*.tgz" ! -path '$(DOC_DIR)/*' -exec rm '{}' +
