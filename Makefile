XCODEBUILD := xcodebuild
BUILD_FLAGS = -scheme $(SCHEME) -destination $(DESTINATION)

SCHEME ?= $(TARGET)-$(PLATFORM)
RELEASE ?= beta
IOS_VERSION ?= 11.3

ifeq ($(PLATFORM),iOS)
		DESTINATION ?= 'platform=iOS Simulator,name=$(IPHONE_NAME),OS=$(IOS_VERSION)'
endif

clean:
		$(XCODEBUILD) clean $(BUILD_FLAGS) $(XCPRETTY)

configs = $(basename $(wildcard the-movie-db-client/Config/*.example))
$(configs):
		cp $@.example $@

configs: $(configs)

bootstrap: brew update || brew update
		brew unlink carthage || true
		brew install carthage
		brew link --overwrite carthage

secrets:
		cp -n Config/Secrets.swift.example Config/Secrets.swift
