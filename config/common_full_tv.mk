# Exclude AudioFX
TARGET_EXCLUDES_AUDIOFX := true

# Inherit full common custom stuff
$(call inherit-product, $(CUSTOM_VENDOR_DIR)/config/common_full.mk)

# Inherit custom atv device tree
# Every custom ROM team can device whether they want to
# support ATV or not. This here doesn't have to exist if you
# don't plan to support it.
$(call inherit-product, device/custom/atv/custom_atv.mk)

PRODUCT_PACKAGES += \
    AppDrawer

DEVICE_PACKAGE_OVERLAYS += $(CUSTOM_VENDOR_DIR)/overlay/tv
