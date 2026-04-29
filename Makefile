PLUGIN_NAME := $(shell pkl eval -f json formae-plugin.pkl | jq -r '.name')
PLUGIN_VERSION := $(shell pkl eval -f json formae-plugin.pkl | jq -r '.version')
INSTALL_DIR := $(HOME)/.pel/formae/plugins/$(PLUGIN_NAME)/v$(PLUGIN_VERSION)

.PHONY: build test test-unit lint install clean

build:
	@mkdir -p schema/pkl && echo "$(PLUGIN_VERSION)" > schema/pkl/VERSION
	@mkdir -p bin
	go build -o bin/$(PLUGIN_NAME) .

test: test-unit

test-unit:
	go test -tags=unit -count=1 -failfast ./...

lint:
	golangci-lint run ./...

install: build
	@echo "Installing $(PLUGIN_NAME) v$(PLUGIN_VERSION) to $(INSTALL_DIR)"
	@mkdir -p $(INSTALL_DIR)/schema/pkl
	cp bin/$(PLUGIN_NAME) $(INSTALL_DIR)/$(PLUGIN_NAME)
	cp formae-plugin.pkl $(INSTALL_DIR)/formae-plugin.pkl
	cp schema/pkl/Config.pkl $(INSTALL_DIR)/schema/pkl/Config.pkl

clean:
	rm -rf bin/ dist/
