# Allow vendor/extra to override any property by setting it first
$(call inherit-product-if-exists, vendor/extra/product.mk)

PRODUCT_BRAND ?= $(CUSTOM_ROM_NAME)

PRODUCT_BUILD_PROP_OVERRIDES += BUILD_UTC_DATE=0

ifeq ($(PRODUCT_GMS_CLIENTID_BASE),)
PRODUCT_SYSTEM_DEFAULT_PROPERTIES += \
    ro.com.google.clientidbase=android-google
else
PRODUCT_SYSTEM_DEFAULT_PROPERTIES += \
    ro.com.google.clientidbase=$(PRODUCT_GMS_CLIENTID_BASE)
endif

# Default notification/alarm sounds
PRODUCT_SYSTEM_DEFAULT_PROPERTIES += \
    ro.config.notification_sound=Argon.ogg \
    ro.config.alarm_alert=Hassium.ogg

ifeq ($(TARGET_BUILD_VARIANT),eng)
# Disable ADB authentication
PRODUCT_SYSTEM_DEFAULT_PROPERTIES += ro.adb.secure=0
else
# Enable ADB authentication
PRODUCT_SYSTEM_DEFAULT_PROPERTIES += ro.adb.secure=1
endif

# Backup Tool
PRODUCT_COPY_FILES += \
    $(CUSTOM_VENDOR_DIR)/prebuilt/common/bin/backuptool.sh:install/bin/backuptool.sh \
    $(CUSTOM_VENDOR_DIR)/prebuilt/common/bin/backuptool.functions:install/bin/backuptool.functions \
    $(CUSTOM_VENDOR_DIR)/prebuilt/common/bin/50-custom.sh:$(TARGET_COPY_OUT_SYSTEM)/addon.d/50-custom.sh \
    $(CUSTOM_VENDOR_DIR)/prebuilt/common/bin/blacklist:$(TARGET_COPY_OUT_SYSTEM)/addon.d/blacklist

# OTA
ifneq ($(TARGET_BUILD_VARIANT),user)
PRODUCT_SYSTEM_DEFAULT_PROPERTIES += \
    ro.ota.allow_downgrade=true
endif

ifneq ($(AB_OTA_PARTITIONS),)
PRODUCT_COPY_FILES += \
    $(CUSTOM_VENDOR_DIR)/prebuilt/common/bin/backuptool_ab.sh:$(TARGET_COPY_OUT_SYSTEM)/bin/backuptool_ab.sh \
    $(CUSTOM_VENDOR_DIR)/prebuilt/common/bin/backuptool_ab.functions:$(TARGET_COPY_OUT_SYSTEM)/bin/backuptool_ab.functions \
    $(CUSTOM_VENDOR_DIR)/prebuilt/common/bin/backuptool_postinstall.sh:$(TARGET_COPY_OUT_SYSTEM)/bin/backuptool_postinstall.sh
endif

# Backup Services whitelist
PRODUCT_COPY_FILES += \
    $(CUSTOM_VENDOR_DIR)/config/permissions/backup.xml:$(TARGET_COPY_OUT_SYSTEM)/etc/sysconfig/backup.xml

# Copy all custom init rc files
$(foreach f,$(wildcard $(CUSTOM_VENDOR_DIR)/prebuilt/common/etc/init/*.rc),\
	$(eval PRODUCT_COPY_FILES += $(f):$(TARGET_COPY_OUT_SYSTEM)/etc/init/$(notdir $f)))

# Copy over added mimetype supported in libcore.net.MimeUtils
PRODUCT_COPY_FILES += \
    $(CUSTOM_VENDOR_DIR)/prebuilt/common/lib/content-types.properties:$(TARGET_COPY_OUT_SYSTEM)/lib/content-types.properties

# Enable Android Beam on all targets
PRODUCT_COPY_FILES += \
    $(CUSTOM_VENDOR_DIR)/config/permissions/android.software.nfc.beam.xml:$(TARGET_COPY_OUT_SYSTEM)/etc/permissions/android.software.nfc.beam.xml

# Enable SIP+VoIP on all targets
PRODUCT_COPY_FILES += \
    frameworks/native/data/etc/android.software.sip.voip.xml:$(TARGET_COPY_OUT_SYSTEM)/etc/permissions/android.software.sip.voip.xml

# Enable wireless Xbox 360 controller support
PRODUCT_COPY_FILES += \
    frameworks/base/data/keyboards/Vendor_045e_Product_028e.kl:$(TARGET_COPY_OUT_SYSTEM)/usr/keylayout/Vendor_045e_Product_0719.kl

# This is a custom ROM
PRODUCT_COPY_FILES += \
    $(CUSTOM_VENDOR_DIR)/config/permissions/privapp-permissions-custom-system.xml:$(TARGET_COPY_OUT_SYSTEM)/etc/permissions/privapp-permissions-custom.xml \
    $(CUSTOM_VENDOR_DIR)/config/permissions/privapp-permissions-custom-product.xml:$(TARGET_COPY_OUT_PRODUCT)/etc/permissions/privapp-permissions-custom.xml

ifneq ($(TARGET_ENFORCE_PRIVAPP_WHITELIST),false)
# Enforce privapp-permissions whitelist
PRODUCT_SYSTEM_DEFAULT_PROPERTIES += \
    ro.control_privapp_permissions=enforce
else
ifeq ($(TARGET_LOG_PRIVAPP_WHITELIST_MISMATCH),true)
PRODUCT_SYSTEM_DEFAULT_PROPERTIES += \
	ro.control_privapp_permissions=log
endif
endif

# Power whitelist
PRODUCT_COPY_FILES += \
    $(CUSTOM_VENDOR_DIR)/config/permissions/custom-power-whitelist.xml:$(TARGET_COPY_OUT_SYSTEM)/etc/sysconfig/custom-power-whitelist.xml

# Include AOSP audio files
include $(CUSTOM_VENDOR_DIR)/config/aosp_audio.mk

# TWRP
ifeq ($(WITH_TWRP),true)
include $(CUSTOM_VENDOR_DIR)/config/twrp.mk
endif

# Google permissions
PRODUCT_COPY_FILES += \
    $(CUSTOM_VENDOR_DIR)/config/permissions/privapp-permissions-elgoog.xml:system/etc/permissions/privapp-permissions-elgoog.xml

# Custom permissions
PRODUCT_COPY_FILES += \
	$(CUSTOM_VENDOR_DIR)/config/permissions/privapp-permissions-custom.xml:system/etc/permissions/privapp-permissions-custom.xml

# Do not include art debug targets
PRODUCT_ART_TARGET_INCLUDE_DEBUG_BUILD := false

# Strip the local variable table and the local variable type table to reduce
# the size of the system image. This has no bearing on stack traces, but will
# leave less information available via JDWP.
PRODUCT_MINIMIZE_JAVA_DEBUG_INFO := true

# Disable vendor restrictions
PRODUCT_RESTRICT_VENDOR_FILES := false

# Bootanimation
PRODUCT_PACKAGES += \
    bootanimation.zip

# AOSP packages
PRODUCT_PACKAGES += \
    ExactCalculator \
    Exchange2 \
    Terminal \
    app_prediction

ifneq ($(TARGET_EXCLUDES_AUDIOFX),true)
PRODUCT_PACKAGES += \
    AudioFX
endif

# Extra tools
PRODUCT_PACKAGES += \
    7z \
    awk \
    bash \
    bzip2 \
    curl \
    getcap \
    htop \
    lib7z \
    libsepol \
    nano \
    pigz \
    setcap \
    unrar \
    vim \
    wget \
    zip

# Charger
PRODUCT_PACKAGES += \
    charger_res_images

# Filesystems tools
PRODUCT_PACKAGES += \
    fsck.exfat \
    fsck.ntfs \
    mke2fs \
    mkfs.exfat \
    mkfs.ntfs \
    mount.ntfs

# Openssh
PRODUCT_PACKAGES += \
    scp \
    sftp \
    ssh \
    sshd \
    sshd_config \
    ssh-keygen \
    start-ssh

# rsync
PRODUCT_PACKAGES += \
    rsync

# Storage manager
PRODUCT_SYSTEM_DEFAULT_PROPERTIES += \
    ro.storage_manager.enabled=true

# Media
PRODUCT_SYSTEM_DEFAULT_PROPERTIES += \
    media.recorder.show_manufacturer_and_model=true

# These packages are excluded from user builds
PRODUCT_PACKAGES_DEBUG += \
    procmem

PRODUCT_ENFORCE_RRO_EXCLUDED_OVERLAYS += $(CUSTOM_VENDOR_DIR)/overlay
DEVICE_PACKAGE_OVERLAYS += $(CUSTOM_VENDOR_DIR)/overlay/common

PRODUCT_PROPERTY_OVERRIDES += \
    persist.sys.disable_rescue=true \
    ro.boot.vendor.overlay.theme=com.android.theme.color.halogen;com.potato.overlay.lawnconf

PRODUCT_PACKAGES += ExactCalculator

PRODUCT_PACKAGES += \
	IconShapeSquareOverlay

PRODUCT_PACKAGES += \
	Launcher3 \
	Launcher3QuickStep

-include $(WORKSPACE)/build_env/image-auto-bits.mk

# In case you are absolutely sure about this, create the file
-include $(CUSTOM_VENDOR_DIR)/config/partner_gms.mk

# GSans font
-include $(CUSTOM_VENDOR_DIR)/config/fonts.mk

# Pixel Style
-include vendor/pixelstyle/config.mk
