# Inherit common custom stuff
$(call inherit-product, $(CUSTOM_VENDOR_DIR)/config/common.mk)

PRODUCT_SIZE := full

PRODUCT_PACKAGES += \
    Recorder \
    Jelly \
	Etar

PRODUCT_PACKAGES += NavigationBarMode2ButtonOverlay

include $(CUSTOM_VENDOR_DIR)/config/packages.mk
