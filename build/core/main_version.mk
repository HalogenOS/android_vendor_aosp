CUSTOM_BUILD_TYPE ?= UNOFFICIAL
CUSTOM_ROM_NAME := halogenOS
CUSTOM_ROM_PREFIX := XOS

# Build fingerprint
ifneq ($(BUILD_FINGERPRINT),)
ADDITIONAL_BUILD_PROPERTIES += \
    ro.build.fingerprint=$(BUILD_FINGERPRINT)
endif

CUSTOM_BUILD_DATE := $(shell date "+%Y%m%d-%H%M%S-%Z")
CUSTOM_BUILD_DATE_UTC := $(shell date -u "+%Y%m%d-%H%M%S")

CUSTOM_VERSION := XOS_$(CUSTOM_BUILD)-$(PLATFORM_VERSION)-$(CUSTOM_BUILD_DATE)-$(CUSTOM_BUILD_TYPE)
ROM_FINGERPRINT := halogenOS/$(CUSTOM_PLATFORM_VERSION)/$(TARGET_PRODUCT_SHORT)/$(CUSTOM_BUILD_DATE)

# ROM System version
ADDITIONAL_BUILD_PROPERTIES += \
		ro.rom.name=$(CUSTOM_ROM_NAME) \
		ro.rom.build_date=$(CUSTOM_BUILD_DATE) \
		ro.rom.build_type=$(CUSTOM_BUILD_TYPE) \
		ro.custom.version=$(CUSTOM_VERSION) \
		ro.custom.build_date=$(CUSTOM_BUILD_DATE) \
		ro.custom.build_date_utc=$(CUSTOM_BUILD_DATE_UTC) \
		ro.custom.build_type=$(CUSTOM_BUILD_TYPE) \
		ro.custom.fingerprint=$(ROM_FINGERPRINT) \
		ro.xos.version=$(PLATFORM_VERSION)_$(CUSTOM_BUILD_DATE)
