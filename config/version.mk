PRODUCT_VERSION_MAJOR = 15
PRODUCT_VERSION_MINOR = 0

# Increase Xtended Version with each major release.
XTENDED_VERSION := 10.3
XTENDED_BUILD_TYPE ?= Unofficial

# Internal version
LINEAGE_VERSION := Project-Xtended-$(PRODUCT_VERSION_MAJOR).$(PRODUCT_VERSION_MINOR)-$(shell date +%Y%m%d)-$(LINEAGE_BUILD)-$(XTENDED_VERSION)-$(XTENDED_BUILD_TYPE)

# Display version
LINEAGE_DISPLAY_VERSION := v$(XTENDED_VERSION)-$(shell date +%Y%m%d)

# Project Xtended version properties
PRODUCT_SYSTEM_PROPERTIES += \
    ro.xtended.build.version=$(LINEAGE_VERSION) \
    ro.xtended.display.version=$(LINEAGE_DISPLAY_VERSION) \
    ro.xtended.version=$(PRODUCT_VERSION_MAJOR).$(PRODUCT_VERSION_MINOR) \
    ro.modversion=$(XTENDED_VERSION)
