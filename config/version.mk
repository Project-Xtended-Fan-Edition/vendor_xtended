PRODUCT_VERSION_MAJOR = 22
PRODUCT_VERSION_MINOR = 1

ifeq ($(LINEAGE_VERSION_APPEND_TIME_OF_DAY),true)
    LINEAGE_BUILD_DATE ?= $(shell date -u +%Y%m%d_%H%M%S)
else
    LINEAGE_BUILD_DATE ?= $(shell date -u +%Y%m%d)
endif

# Set LINEAGE_BUILDTYPE from the env RELEASE_TYPE, for jenkins compat

ifndef LINEAGE_BUILDTYPE
    ifdef RELEASE_TYPE
        # Starting with "LINEAGE_" is optional
        RELEASE_TYPE ?= $(shell echo $(RELEASE_TYPE) | sed -e 's|^LINEAGE_||g')
        LINEAGE_BUILDTYPE ?= $(RELEASE_TYPE)
    endif
endif

# Filter out random types, so it'll reset to UNOFFICIAL
ifeq ($(filter RELEASE NIGHTLY SNAPSHOT EXPERIMENTAL,$(LINEAGE_BUILDTYPE)),)
    LINEAGE_BUILDTYPE ?= UNOFFICIAL
    LINEAGE_EXTRAVERSION ?=
endif

ifeq ($(LINEAGE_BUILDTYPE), UNOFFICIAL)
    ifneq ($(TARGET_UNOFFICIAL_BUILD_ID),)
        LINEAGE_EXTRAVERSION ?= -$(TARGET_UNOFFICIAL_BUILD_ID)
    endif
endif

LINEAGE_VERSION_SUFFIX ?= $(LINEAGE_BUILD_DATE)-$(LINEAGE_BUILDTYPE)$(LINEAGE_EXTRAVERSION)-$(LINEAGE_BUILD)

# Internal version
LINEAGE_VERSION ?= $(PRODUCT_VERSION_MAJOR).$(PRODUCT_VERSION_MINOR)-$(LINEAGE_VERSION_SUFFIX)

# Display version
LINEAGE_DISPLAY_VERSION ?= $(PRODUCT_VERSION_MAJOR)-$(LINEAGE_VERSION_SUFFIX)

# LineageOS version properties
PRODUCT_SYSTEM_PROPERTIES += \
    ro.custom.version?=$(LINEAGE_VERSION) \
    ro.custom.display.version?=$(LINEAGE_DISPLAY_VERSION) \
    ro.custom.build.version?=$(PRODUCT_VERSION_MAJOR).$(PRODUCT_VERSION_MINOR) \
    ro.custom.sdk.build.version?=$(PRODUCT_VERSION_MAJOR).$(PRODUCT_VERSION_MINOR) \
    ro.custom.releasetype?=$(LINEAGE_BUILDTYPE) \
    ro.modversion?=$(LINEAGE_VERSION)
