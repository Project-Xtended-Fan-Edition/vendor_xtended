# Project Xtended packages
PRODUCT_PACKAGES += \
    EvoEgg

ifeq ($(XTENDED_BUILD_TYPE),Official)
PRODUCT_PACKAGES += \
    Updater
endif

# Private keys
ifeq ($(XTENDED_BUILD_TYPE),Official)
include vendor/evolution-priv/keys/keys.mk
else
-include vendor/evolution-priv/keys/keys.mk
endif
