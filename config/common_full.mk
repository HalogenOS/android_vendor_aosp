# Inherit common custom stuff
$(call inherit-product, $(CUSTOM_VENDOR_DIR)/config/common.mk)

PRODUCT_SIZE := full

# Recorder
PRODUCT_PACKAGES += \
    Recorder \
    Jelly

PRODUCT_PACKAGES += NavigationBarMode2ButtonOverlay
