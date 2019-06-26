
include $(CUSTOM_VENDOR_DIR)/config/BoardConfigKernel.mk

ifeq ($(BOARD_USES_QCOM_HARDWARE),true)
include $(CUSTOM_VENDOR_DIR)/config/BoardConfigQcom.mk
endif

# SEPolicy
BOARD_PLAT_PRIVATE_SEPOLICY_DIR += \
    $(CUSTOM_VENDOR_DIR)/sepolicy/private

BOARD_PLAT_PUBLIC_SEPOLICY_DIR += \
    $(CUSTOM_VENDOR_DIRj)/sepolicy/public

include $(CUSTOM_VENDOR_DIR)/config/BoardConfigSoong.mk
