# Inherit mini common custom stuff
$(call inherit-product, $(CUSTOM_VENDOR_DIR)/config/common_mini.mk)

# Required packages
PRODUCT_PACKAGES += \
    LatinIME

$(call inherit-product, $(CUSTOM_VENDOR_DIR)/config/telephony.mk)
