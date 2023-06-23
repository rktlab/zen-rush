# Use one shell for the whole recipe, instead of per-line
.ONESHELL:
# Use bash in strict mode
SHELL := bash
.SHELLFLAGS = -eu -o pipefail -c

# Sane makefile settings to avoid the unexpected
MAKEFLAGS += --warn-undefined-variables
MAKEFLAGS += --no-builtin-rules --no-builtin-variables

# Absolute path to the project root
root := $(shell git rev-parse --show-toplevel)
# We give access to this to every targets
export root

SOURCES = $(shell find src -name '*.lua')
ASSETS = $(shell find src/assets -type f)

.PHONY: build
build: _build/game.love
_build/game.love: $(SOURCES) $(ASSETS)
	@mkdir -p $$(dirname $@)
	rm $@ || true
	cd src && zip -q -r ../$@ *

.PHONY: run
run:
	@love src

.PHONY: run-release
run-release: _build/game.love
	@love $<

.PHONY: test
test:
	busted

.PHONY: watch-test
watch-test:
	set +e
	while sleep 0.1; do git ls-files | entr -cd make test; done

.PHONY: watch-lint
watch-lint:
	luacheck  src/**/*.lua~src/vendors/* spec/**/*.lua

.PHONY: fmt
fmt: $(SOURCES)
	for f in $(SOURCES); do
		luafmt -l 80 -i 2 -w replace "$$f";
	done
