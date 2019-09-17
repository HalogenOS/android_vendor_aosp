# Exclude AudioFX
TARGET_EXCLUDES_AUDIOFX := true

# Inherit mini common custom stuff
$(call inherit-product, $(CUSTOM_VENDOR_DIR)/config/common_mini.mk)
